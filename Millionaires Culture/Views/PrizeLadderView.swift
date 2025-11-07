//
//  PrizeLadderView.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import SwiftUI

struct PrizeLadderView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Escalera de Premios")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                .padding(.bottom, 15)
            
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(Array(fixedPrizes.enumerated().reversed()), id: \.offset) { index, prize in
                            let actualIndex = fixedPrizes.count - 1 - index
                            let isSafe = safeLevels.contains(actualIndex)
                            let isCurrent = actualIndex == viewModel.currentQuestionIndex
                            let isPassed = actualIndex < viewModel.currentQuestionIndex
                            
                            PrizeLadderItem(
                                prize: prize,
                                isSafe: isSafe,
                                isCurrent: isCurrent,
                                isPassed: isPassed
                            )
                            .id(actualIndex)
                        }
                    }
                }
                .frame(maxHeight: 400)
                .onChange(of: viewModel.currentQuestionIndex) { newValue in
                    withAnimation {
                        proxy.scrollTo(newValue, anchor: .center)
                    }
                }
            }
        }
        .padding()
        .background(Color(red: 0.12, green: 0.12, blue: 0.12))
        .cornerRadius(15)
    }
}

struct PrizeLadderItem: View {
    let prize: Int
    let isSafe: Bool
    let isCurrent: Bool
    let isPassed: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Text("$\(formatCurrency(prize))")
                .font(.system(size: isCurrent ? 18 : 16, weight: isCurrent ? .bold : .semibold))
                .foregroundColor(isCurrent ? Color(red: 0.05, green: 0.1, blue: 0.2) : 
                                isPassed ? Color.gray : 
                                Color(red: 0.95, green: 0.75, blue: 0.3))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 15)
        .background(
            ZStack {
                if isCurrent {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.95, green: 0.75, blue: 0.3))
                        .shadow(color: Color(red: 0.95, green: 0.75, blue: 0.3).opacity(0.6), radius: 10)
                } else if isSafe {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.8, green: 0.6, blue: 0.2).opacity(0.3))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 0.95, green: 0.75, blue: 0.3), lineWidth: 2)
                        )
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                }
            }
        )
        .scaleEffect(isCurrent ? 1.05 : 1.0)
        .animation(.spring(response: 0.3), value: isCurrent)
    }
    
    private func formatCurrency(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ","
        return formatter.string(from: NSNumber(value: amount)) ?? "\(amount)"
    }
}
