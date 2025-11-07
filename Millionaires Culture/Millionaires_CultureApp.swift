//
//  Millionaires_CultureApp.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import SwiftUI

@main
struct Millionaires_CultureApp: App {
    @StateObject private var languageManager = LanguageManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(languageManager)
        }
    }
}
