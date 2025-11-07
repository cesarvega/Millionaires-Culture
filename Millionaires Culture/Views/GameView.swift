//
//  GameView.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    @Binding var showGame: Bool
    @State private var showPrizeLadder = false
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.07, green: 0.07, blue: 0.07),
                    Color(red: 0.02, green: 0.05, blue: 0.15)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            GeometryReader { geometry in
                Group {
                    if geometry.size.width > 800 {
                        gameContent
                            .frame(maxWidth: min(800, geometry.size.width * 0.7))
                            .padding()
                    } else {
                        ScrollView {
                            gameContent
                                .padding(.vertical, 20)
                                .padding(.horizontal)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // Modal overlay
            if viewModel.showModal {
                modalView
            }
            
            if showPrizeLadder {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            showPrizeLadder = false
                        }
                    }
                
                VStack(spacing: 15) {
                    HStack {
                        Text(languageManager.text(.prizeLadderTitle))
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        Button(role: .cancel) {
                            withAnimation {
                                showPrizeLadder = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                    }
                    
                    PrizeLadderView(viewModel: viewModel)
                        .frame(maxWidth: 320)
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(20)
                .padding()
                .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    showGame = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text(languageManager.currentLanguage == .spanish ? "Menú" : "Menu")
                    }
                    .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                }
            }
        }
    }
    
    var gameContent: some View {
        VStack(spacing: 25) {
            controlBar
            
            // Title header
            Text(languageManager.text(.gameTitle))
                .font(.system(size: 32, weight: .heavy))
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(red: 0.95, green: 0.75, blue: 0.3),
                            Color(red: 0.8, green: 0.6, blue: 0.2)
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .shadow(color: Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.5), radius: 5)
            
            // Lifelines
            lifelinesView
            
            // Question area
            if let question = viewModel.currentQuestion {
                questionView(question: question)
            }
            
            // Answer options
            if let question = viewModel.currentQuestion {
                optionsView(question: question)
            }
        }
        .padding()
        .background(Color(red: 0.12, green: 0.12, blue: 0.12))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
    
    var controlBar: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 12) {
                Button(action: {
                    withAnimation {
                        showPrizeLadder = true
                    }
                }) {
                    Image(systemName: "list.number")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color(red: 0.95, green: 0.75, blue: 0.3))
                        .clipShape(Circle())
                        .shadow(radius: 4, y: 2)
                        .overlay(
                            Circle()
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
                
                LanguageToggleButton()
                    .frame(height: 44)
                
                Spacer()
                
                winningsBadge
                
                Button(action: {
                    viewModel.giveUp()
                }) {
                    Text(languageManager.text(.cashOutButton))
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 18)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(12)
                }
                .disabled(viewModel.gameState != .playing)
                .opacity(viewModel.gameState == .playing ? 1 : 0.6)
            }
        }
    }
    
    var winningsBadge: some View {
        HStack(spacing: 8) {
            Image(systemName: "dollarsign.circle.fill")
                .foregroundColor(Color(red: 0.1, green: 0.5, blue: 0.1))
                .font(.system(size: 22))
            VStack(alignment: .leading, spacing: 2) {
                Text(languageManager.text(.winningsLabel))
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white.opacity(0.8))
                Text("$\(viewModel.formatCurrency(viewModel.accumulatedPrize))")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(red: 0.17, green: 0.17, blue: 0.2))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.5), lineWidth: 1)
        )
    }
    
    var lifelinesView: some View {
        HStack(spacing: 30) {
            LifelineGameButton(
                icon: "circle.slash",
                label: languageManager.text(.lifelineFifty),
                isAvailable: viewModel.lifelines[.fiftyFifty] ?? false
            ) {
                viewModel.useLifeline(.fiftyFifty)
            }
            
            LifelineGameButton(
                icon: "lightbulb.fill",
                label: languageManager.text(.lifelineExpert),
                isAvailable: viewModel.lifelines[.expert] ?? false
            ) {
                viewModel.useLifeline(.expert)
            }
            
            LifelineGameButton(
                icon: "person.3.fill",
                label: languageManager.text(.lifelineAudience),
                isAvailable: viewModel.lifelines[.audience] ?? false
            ) {
                viewModel.useLifeline(.audience)
            }
        }
        .padding()
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(15)
    }
    
    func questionView(question: Question) -> some View {
        VStack(spacing: 15) {
            Text("\(languageManager.currentPrizeLabel()): $\(viewModel.formatCurrency(viewModel.currentPrize))")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
            
            if safeLevels.contains(question.questionIndex) {
                Text("**\(languageManager.safeLevelLabel())**")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.green)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)
                    .background(Color.green.opacity(0.2))
                    .cornerRadius(8)
            }
            
            Text(question.questionText)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(red: 0.07, green: 0.07, blue: 0.07))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.5), lineWidth: 3)
        )
    }
    
    func optionsView(question: Question) -> some View {
        let shuffledOptions = question.shuffledOptions
        let labels = ["A", "B", "C", "D"]
        
        return LazyVGrid(columns: [
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15)
        ], spacing: 15) {
            ForEach(Array(shuffledOptions.enumerated()), id: \.offset) { index, option in
                let isEliminated = viewModel.eliminatedOptions.contains(option)
                let isSelected = viewModel.selectedAnswer == option
                let isCorrect = option == question.correctAnswer
                let showResult = viewModel.showCorrectAnswer
                
                AnswerButton(
                    label: labels[index],
                    text: option,
                    eliminatedLabel: languageManager.eliminatedTag(),
                    isEliminated: isEliminated,
                    isSelected: isSelected,
                    isCorrect: isCorrect,
                    showResult: showResult
                ) {
                    if viewModel.gameState == .playing && !isEliminated {
                        viewModel.checkAnswer(option)
                    }
                }
            }
        }
    }
    
    var modalView: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    // Prevent closing on background tap
                }
            
            VStack(spacing: 20) {
                Text(viewModel.modalTitle)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [
                                Color(red: 0.95, green: 0.75, blue: 0.3),
                                Color(red: 0.8, green: 0.6, blue: 0.2)
                            ],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .multilineTextAlignment(.center)
                
                if viewModel.modalMessage == "audience_poll" {
                    audiencePollView
                } else {
                    Text(viewModel.modalMessage)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Button(action: {
                    viewModel.closeModal()
                }) {
                    Text(viewModel.gameState == .gameOver || viewModel.gameState == .won ? languageManager.text(.modalPlayAgain) : languageManager.text(.modalContinue))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(Color(red: 0.05, green: 0.1, blue: 0.2))
                        .padding(.vertical, 12)
                        .padding(.horizontal, 40)
                        .background(Color(red: 0.95, green: 0.75, blue: 0.3))
                        .cornerRadius(10)
                        .shadow(color: Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.5), radius: 10)
                }
            }
            .padding(30)
            .background(Color(red: 0.12, green: 0.12, blue: 0.12))
            .cornerRadius(20)
            .shadow(radius: 20)
            .padding(40)
        }
    }
    
    var audiencePollView: some View {
        VStack(spacing: 15) {
            Text(languageManager.text(.audienceIntro))
                .font(.system(size: 18))
                .foregroundColor(.white)
            
            ForEach(Array(viewModel.audiencePoll.keys.sorted()), id: \.self) { key in
                if let percent = viewModel.audiencePoll[key] {
                    HStack {
                        Text("\(key):")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                            .frame(width: 30)
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 30)
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.8))
                                    .frame(width: geometry.size.width * CGFloat(percent) / 100, height: 30)
                                
                                if percent > 0 {
                                    Text("\(percent)%")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color(red: 0.05, green: 0.1, blue: 0.2))
                                        .padding(.leading, 8)
                                }
                            }
                        }
                        .frame(height: 30)
                    }
                }
            }
        }
        .padding()
    }
}

struct LifelineGameButton: View {
    let icon: String
    let label: String
    let isAvailable: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(isAvailable ? Color(red: 0.95, green: 0.75, blue: 0.3) : .gray)
                
                Text(label)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(isAvailable ? Color(red: 0.95, green: 0.75, blue: 0.3) : .gray)
            }
            .padding()
            .background(
                Circle()
                    .stroke(isAvailable ? Color(red: 0.95, green: 0.75, blue: 0.3) : .gray, lineWidth: 2)
                    .frame(width: 70, height: 70)
            )
            .opacity(isAvailable ? 1.0 : 0.3)
        }
        .disabled(!isAvailable)
    }
}

struct AnswerButton: View {
    let label: String
    let text: String
    let eliminatedLabel: String
    let isEliminated: Bool
    let isSelected: Bool
    let isCorrect: Bool
    let showResult: Bool
    let action: () -> Void
    
    var backgroundColor: Color {
        if isEliminated {
            return Color.gray.opacity(0.2)
        }
        if showResult {
            if isCorrect {
                return Color.green
            } else if isSelected {
                return Color.red
            }
        }
        if isSelected {
            return Color(red: 0.8, green: 0.6, blue: 0.2)
        }
        return Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.1)
    }
    
    var borderColor: Color {
        if isEliminated {
            return Color.gray
        }
        if showResult && isCorrect {
            return Color.green
        }
        if showResult && isSelected {
            return Color.red
        }
        return Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.3)
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(label):")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isEliminated ? .gray : Color(red: 0.95, green: 0.75, blue: 0.3))
                
                if isEliminated {
                    Text(eliminatedLabel)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                        .strikethrough()
                } else {
                    Text(text)
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.white)
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, minHeight: 60)
            .background(backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .disabled(isEliminated || showResult)
        .scaleEffect(isSelected && !showResult ? 0.98 : 1.0)
        .animation(.spring(response: 0.3), value: isSelected)
        .animation(.spring(response: 0.3), value: showResult)
    }
}
