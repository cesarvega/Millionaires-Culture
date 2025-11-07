//
//  ContentView.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showGame = false
    
    var body: some View {
        NavigationStack {
            if showGame {
                GameView(showGame: $showGame)
            } else {
                MenuView(showGame: $showGame)
            }
        }
    }
}

#Preview {
    ContentView()
}
