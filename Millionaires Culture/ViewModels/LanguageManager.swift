//
//  LanguageManager.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/8/25.
//

import Foundation

enum AppLanguage: String {
    case spanish = "es"
    case english = "en"
    
    var code: String {
        switch self {
        case .spanish: return "ES"
        case .english: return "EN"
        }
    }
}

enum LocalizedKey {
    case menuTitleTop
    case menuTitleBottom
    case playButton
    case lifelinesTitle
    case leaderboard
    case settings
    case howToPlay
    case gameTitle
    case winningsLabel
    case cashOutButton
    case prizeLadderTitle
    case lifelineFifty
    case lifelineExpert
    case lifelineAudience
    case modalContinue
    case modalPlayAgain
    case audienceIntro
}

@MainActor
final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()
    private static let storageKey = "appLanguage"
    
    @Published var currentLanguage: AppLanguage {
        didSet {
            UserDefaults.standard.set(currentLanguage.rawValue, forKey: Self.storageKey)
        }
    }
    
    private init() {
        if let saved = UserDefaults.standard.string(forKey: Self.storageKey),
           let storedLanguage = AppLanguage(rawValue: saved) {
            currentLanguage = storedLanguage
        } else {
            currentLanguage = .spanish
        }
    }
    
    func toggleLanguage() {
        currentLanguage = currentLanguage == .spanish ? .english : .spanish
    }
    
    func text(_ key: LocalizedKey) -> String {
        switch (key, currentLanguage) {
        case (.menuTitleTop, .spanish): return "¿QUIÉN QUIERE SER"
        case (.menuTitleTop, .english): return "WHO WANTS TO BE"
            
        case (.menuTitleBottom, .spanish): return "MILLONARIO?"
        case (.menuTitleBottom, .english): return "MILLIONAIRE?"
            
        case (.playButton, .spanish): return "JUGAR"
        case (.playButton, .english): return "PLAY"
            
        case (.lifelinesTitle, .spanish): return "COMODINES"
        case (.lifelinesTitle, .english): return "LIFELINES"
            
        case (.leaderboard, .spanish): return "CLASIFICACIÓN"
        case (.leaderboard, .english): return "LEADERBOARD"
            
        case (.settings, .spanish): return "AJUSTES"
        case (.settings, .english): return "SETTINGS"
            
        case (.howToPlay, .spanish): return "CÓMO JUGAR"
        case (.howToPlay, .english): return "HOW TO PLAY"
            
        case (.gameTitle, .spanish): return "Cultura-Millonaria"
        case (.gameTitle, .english): return "Culture Millionaire"
            
        case (.winningsLabel, .spanish): return "Ganado"
        case (.winningsLabel, .english): return "Winnings"
            
        case (.cashOutButton, .spanish): return "Retirarse"
        case (.cashOutButton, .english): return "Cash Out"
            
        case (.prizeLadderTitle, .spanish): return "Escalera de Premios"
        case (.prizeLadderTitle, .english): return "Prize Ladder"
            
        case (.lifelineFifty, .spanish): return "50:50"
        case (.lifelineFifty, .english): return "50:50"
            
        case (.lifelineExpert, .spanish): return "Experto"
        case (.lifelineExpert, .english): return "Expert"
            
        case (.lifelineAudience, .spanish): return "Audiencia"
        case (.lifelineAudience, .english): return "Audience"
            
        case (.modalContinue, .spanish): return "Continuar"
        case (.modalContinue, .english): return "Continue"
            
        case (.modalPlayAgain, .spanish): return "Jugar de Nuevo"
        case (.modalPlayAgain, .english): return "Play Again"
            
        case (.audienceIntro, .spanish): return "La audiencia ha votado así:"
        case (.audienceIntro, .english): return "Audience voting results:"
        }
    }
    
    func currentPrizeLabel() -> String {
        currentLanguage == .spanish ? "Premio Actual" : "Current Prize"
    }
    
    func safeLevelLabel() -> String {
        currentLanguage == .spanish ? "NIVEL SEGURO" : "SAFE LEVEL"
    }
    
    func withdrawTitle() -> String {
        currentLanguage == .spanish ? "¡Retirada Exitosa!" : "Successful Withdrawal!"
    }
    
    func withdrawMessage(amount: String) -> String {
        if currentLanguage == .spanish {
            return "¡Has decidido retirarte con una ganancia de $\(amount)! ¡Bien jugado!"
        } else {
            return "You decided to cash out with $\(amount)! Well played!"
        }
    }
    
    func withdrawZeroMessage() -> String {
        if currentLanguage == .spanish {
            return "¡Has decidido retirarte con una ganancia de $0! ¡Bien jugado!"
        } else {
            return "You decided to cash out with $0! Well played!"
        }
    }
    
    func winTitle() -> String {
        currentLanguage == .spanish ? "¡Felicidades, Millonario de Cultura General!" : "Congratulations, Culture Millionaire!"
    }
    
    func winMessage(amount: String) -> String {
        if currentLanguage == .spanish {
            return "¡Has ganado $\(amount)! Has superado todas las preguntas."
        } else {
            return "You won $\(amount)! You cleared every question."
        }
    }
    
    func gameOverTitle() -> String {
        currentLanguage == .spanish ? "¡GAME OVER! ¡Inténtalo de Nuevo!" : "Game Over! Try Again!"
    }
    
    func gameOverMessage(correctAnswer: String, safePrize: String) -> String {
        if currentLanguage == .spanish {
            return "La respuesta correcta era: \(correctAnswer).\n\nTe llevas $\(safePrize)."
        } else {
            return "The correct answer was: \(correctAnswer).\n\nYou leave with $\(safePrize)."
        }
    }
    
    func lifelineTitle(for type: LifelineType) -> String {
        switch (type, currentLanguage) {
        case (.fiftyFifty, .spanish): return "Comodín 50:50"
        case (.fiftyFifty, .english): return "50:50 Lifeline"
        case (.expert, .spanish): return "Consejo del Experto"
        case (.expert, .english): return "Expert Advice"
        case (.audience, .spanish): return "Votación de la Audiencia Global"
        case (.audience, .english): return "Global Audience Poll"
        }
    }
    
    func lifelineMessage(for type: LifelineType, hint: String? = nil) -> String {
        switch (type, currentLanguage) {
        case (.fiftyFifty, .spanish):
            return "Dos opciones incorrectas han sido eliminadas. ¡Elige sabiamente!"
        case (.fiftyFifty, .english):
            return "Two incorrect options have been removed. Choose wisely!"
        case (.expert, .spanish):
            return "El experto te sugiere: \"\(hint ?? "")\""
        case (.expert, .english):
            return "The expert suggests: \"\(hint ?? "")\""
        case (.audience, .spanish):
            return "audience_poll"
        case (.audience, .english):
            return "audience_poll"
        }
    }
}
