//
//  LanguageToggleButton.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/8/25.
//

import SwiftUI

struct LanguageToggleButton: View {
    @EnvironmentObject private var languageManager: LanguageManager
    
    var body: some View {
        Button(action: {
            languageManager.toggleLanguage()
        }) {
            HStack(spacing: 6) {
                Image(systemName: "globe")
                    .font(.system(size: 14, weight: .semibold))
                Text(languageManager.currentLanguage.code)
                    .font(.system(size: 12, weight: .bold))
            }
            .foregroundColor(.black)
            .padding(.vertical, 6)
            .padding(.horizontal, 10)
            .background(Color(red: 0.95, green: 0.75, blue: 0.3))
            .cornerRadius(14)
            .shadow(radius: 3, y: 2)
        }
        .accessibilityLabel("Change Language")
    }
}
