//
//  GameViewModel.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

enum LifelineType {
    case fiftyFifty
    case expert
    case audience
}

enum GameState {
    case playing
    case answering
    case gameOver
    case won
}

class GameViewModel: ObservableObject {
    @Published var currentQuestionIndex = 0
    @Published var gameQuestions: [Question] = []
    @Published var lifelines: [LifelineType: Bool] = [
        .fiftyFifty: true,
        .expert: true,
        .audience: true
    ]
    @Published var gameState: GameState = .playing
    @Published var showModal = false
    @Published var modalTitle = ""
    @Published var modalMessage = ""
    @Published var eliminatedOptions: Set<UUID> = []
    @Published var selectedOptionID: UUID?
    @Published var showCorrectAnswer = false
    @Published var audiencePoll: [String: Int] = [:]
    
    private let soundPlayer = GameSoundPlayer.shared
    private let languageManager = LanguageManager.shared
    
    var currentQuestion: Question? {
        guard currentQuestionIndex < gameQuestions.count else { return nil }
        return gameQuestions[currentQuestionIndex]
    }
    
    var currentPrize: Int {
        guard currentQuestionIndex < fixedPrizes.count else { return 0 }
        return fixedPrizes[currentQuestionIndex]
    }
    
    var safePrizeWon: Int {
        if currentQuestionIndex == 0 { return 0 }
        
        // Find the last safe level reached before current question
        for i in stride(from: currentQuestionIndex - 1, through: 0, by: -1) {
            if safeLevels.contains(i) {
                return fixedPrizes[i]
            }
        }
        return 0
    }
    
    var accumulatedPrize: Int {
        if gameState == .won {
            return fixedPrizes.last ?? 0
        }
        
        guard currentQuestionIndex > 0 else { return 0 }
        let lastCompletedIndex = min(currentQuestionIndex - 1, fixedPrizes.count - 1)
        return fixedPrizes[lastCompletedIndex]
    }
    
    init() {
        setupNewGame()
    }
    
    func setupNewGame() {
        currentQuestionIndex = 0
        gameState = .playing
        eliminatedOptions.removeAll()
        selectedOptionID = nil
        showCorrectAnswer = false
        audiencePoll.removeAll()
        
        // Reset lifelines
        lifelines = [
            .fiftyFifty: true,
            .expert: true,
            .audience: true
        ]
        
        // Shuffle and select 15 unique questions
        let shuffledPool = questionPool.shuffled()
        let selectedQuestions = shuffledPool.prefix(15)
        
        gameQuestions = selectedQuestions.enumerated().map { index, content in
            content.makeQuestion(prize: fixedPrizes[index], index: index)
        }
    }
    
    func useLifeline(_ type: LifelineType) {
        guard lifelines[type] == true else { return }
        guard let question = currentQuestion else { return }
        
        lifelines[type] = false
        
        switch type {
        case .fiftyFifty:
            // Remove 2 incorrect answers
            let incorrectOptions = question.options.filter { $0.id != question.correctOptionID }
            let toEliminate = incorrectOptions.shuffled().prefix(2)
            eliminatedOptions.formUnion(toEliminate.map { $0.id })
            
            modalTitle = languageManager.lifelineTitle(for: .fiftyFifty)
            modalMessage = languageManager.lifelineMessage(for: .fiftyFifty)
            showModal = true
            
        case .expert:
            modalTitle = languageManager.lifelineTitle(for: .expert)
            modalMessage = languageManager.lifelineMessage(
                for: .expert,
                hint: question.hint(for: languageManager.currentLanguage)
            )
            showModal = true
            
        case .audience:
            // Simulate audience poll
            let correctPercentage = Int.random(in: 50...70)
            var remaining = 100 - correctPercentage
            
            var poll: [String: Int] = [:]
            let labels = ["A", "B", "C", "D"]
            
            for (index, option) in question.options.enumerated() {
                if option.id == question.correctOptionID {
                    poll[labels[index]] = correctPercentage
                } else {
                    let share = index == question.options.count - 1 ? remaining : Int.random(in: 0...remaining)
                    poll[labels[index]] = share
                    remaining -= share
                }
            }
            
            audiencePoll = poll
            modalTitle = languageManager.lifelineTitle(for: .audience)
            modalMessage = "audience_poll"
            showModal = true
        }
    }
    
    func checkAnswer(optionID: UUID) {
        guard let question = currentQuestion else { return }
        
        selectedOptionID = optionID
        gameState = .answering
        
        let isCorrect = optionID == question.correctOptionID
        let language = languageManager.currentLanguage
        let correctAnswerText = question.correctAnswer(for: language)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showCorrectAnswer = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if isCorrect {
                    if self.currentQuestionIndex == self.gameQuestions.count - 1 {
                        // Won the game
                        self.gameState = .won
                        self.modalTitle = self.languageManager.winTitle()
                        self.modalMessage = self.languageManager.winMessage(amount: self.formatCurrency(1000000))
                        self.showModal = true
                    } else {
                        // Move to next question
                        self.nextQuestion()
                    }
                } else {
                    // Game over
                    self.soundPlayer.playIncorrect()
                    self.gameState = .gameOver
                    self.modalTitle = self.languageManager.gameOverTitle()
                    self.modalMessage = self.languageManager.gameOverMessage(
                        correctAnswer: correctAnswerText,
                        safePrize: self.formatCurrency(self.safePrizeWon)
                    )
                    self.showModal = true
                }
            }
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        eliminatedOptions.removeAll()
        selectedOptionID = nil
        showCorrectAnswer = false
        audiencePoll.removeAll()
        gameState = .playing
    }
    
    func giveUp() {
        gameState = .gameOver
        modalTitle = languageManager.withdrawTitle()
        let winnings = accumulatedPrize
        modalMessage = winnings > 0
            ? languageManager.withdrawMessage(amount: formatCurrency(winnings))
            : languageManager.withdrawZeroMessage()
        showModal = true
    }
    
    func formatCurrency(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
    
    func closeModal() {
        showModal = false
        if gameState == .gameOver || gameState == .won {
            setupNewGame()
        }
    }
}

final class GameSoundPlayer {
    static let shared = GameSoundPlayer()
    private var players: [String: AVAudioPlayer] = [:]
    
    private init() {}
    
    func playIncorrect() {
        playSound(named: "incorrect")
    }
    
    private func playSound(named: String, fileExtension: String = "mp3") {
        let key = "\(named).\(fileExtension)"
        
        if players[key] == nil {
            guard let url = Bundle.main.url(forResource: named, withExtension: fileExtension) else {
                print("⚠️ \(key) not found in bundle.")
                return
            }
            
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                players[key] = player
            } catch {
                print("⚠️ Failed to load \(key): \(error.localizedDescription)")
                return
            }
        }
        
        guard let player = players[key] else { return }
        player.currentTime = 0
        player.play()
    }
}
