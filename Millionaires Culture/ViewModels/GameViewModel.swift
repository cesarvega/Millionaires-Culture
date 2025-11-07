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
    @Published var eliminatedOptions: Set<String> = []
    @Published var selectedAnswer: String?
    @Published var showCorrectAnswer = false
    @Published var audiencePoll: [String: Int] = [:]
    
    private let soundPlayer = GameSoundPlayer.shared
    
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
        selectedAnswer = nil
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
            Question(
                questionText: content.question,
                options: content.options,
                correctAnswer: content.answer,
                hint: content.hint,
                prize: fixedPrizes[index],
                questionIndex: index
            )
        }
    }
    
    func useLifeline(_ type: LifelineType) {
        guard lifelines[type] == true else { return }
        guard let question = currentQuestion else { return }
        
        lifelines[type] = false
        
        switch type {
        case .fiftyFifty:
            // Remove 2 incorrect answers
            let incorrectOptions = question.options.filter { $0 != question.correctAnswer }
            let toEliminate = incorrectOptions.shuffled().prefix(2)
            eliminatedOptions.formUnion(toEliminate)
            
            modalTitle = "Comodín 50:50"
            modalMessage = "Dos opciones incorrectas han sido eliminadas. ¡Elige sabiamente!"
            showModal = true
            
        case .expert:
            modalTitle = "Consejo del Experto"
            modalMessage = "El experto te sugiere: \"\(question.hint)\""
            showModal = true
            
        case .audience:
            // Simulate audience poll
            let correctPercentage = Int.random(in: 50...70)
            var remaining = 100 - correctPercentage
            
            var poll: [String: Int] = [:]
            let labels = ["A", "B", "C", "D"]
            
            for (index, option) in question.options.enumerated() {
                if option == question.correctAnswer {
                    poll[labels[index]] = correctPercentage
                } else {
                    let share = index == question.options.count - 1 ? remaining : Int.random(in: 0...remaining)
                    poll[labels[index]] = share
                    remaining -= share
                }
            }
            
            audiencePoll = poll
            modalTitle = "Votación de la Audiencia Global"
            modalMessage = "audience_poll"
            showModal = true
        }
    }
    
    func checkAnswer(_ answer: String) {
        guard let question = currentQuestion else { return }
        
        selectedAnswer = answer
        gameState = .answering
        
        let isCorrect = answer == question.correctAnswer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showCorrectAnswer = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if isCorrect {
                    if self.currentQuestionIndex == self.gameQuestions.count - 1 {
                        // Won the game
                        self.gameState = .won
                        self.modalTitle = "¡Felicidades, Millonario de Cultura General!"
                        self.modalMessage = "¡Has ganado $\(self.formatCurrency(1000000))! Has superado todas las preguntas."
                        self.showModal = true
                    } else {
                        // Move to next question
                        self.nextQuestion()
                    }
                } else {
                    // Game over
                    self.soundPlayer.playIncorrect()
                    self.gameState = .gameOver
                    self.modalTitle = "¡GAME OVER! ¡Inténtalo de Nuevo!"
                    self.modalMessage = "La respuesta correcta era: \(question.correctAnswer).\n\nTe llevas $\(self.formatCurrency(self.safePrizeWon))."
                    self.showModal = true
                }
            }
        }
    }
    
    func nextQuestion() {
        currentQuestionIndex += 1
        eliminatedOptions.removeAll()
        selectedAnswer = nil
        showCorrectAnswer = false
        audiencePoll.removeAll()
        gameState = .playing
    }
    
    func giveUp() {
        gameState = .gameOver
        modalTitle = "¡Retirada Exitosa!"
        let winnings = accumulatedPrize
        modalMessage = winnings > 0
            ? "¡Has decidido retirarte con una ganancia de $\(formatCurrency(winnings))! ¡Bien jugado!"
            : "¡Has decidido retirarte con una ganancia de $0! ¡Bien jugado!"
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
