//
//  MenuView.swift
//  Millionaires Culture
//
//  Created by Cesar Vega on 11/7/25.
//

import SwiftUI
import AVFoundation

struct MenuView: View {
    @Binding var showGame: Bool
    private let soundPlayer = PlayButtonSoundPlayer.shared
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.1, blue: 0.2),
                    Color(red: 0.02, green: 0.05, blue: 0.15)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top decorative bar
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0.8, green: 0.6, blue: 0.2),
                                Color(red: 0.95, green: 0.75, blue: 0.3)
                            ]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(height: 8)
                    .padding(.top, 60)
                
                Spacer()
                
                // Main content
                VStack(spacing: 40) {
                    // Logo with coins and question mark
                    VStack(spacing: 15) {
                        Image(systemName: "questionmark.circle.fill")
                            .font(.system(size: 60))
                            .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                        
                        // Title
                        VStack(spacing: 5) {
                            Text("WHO WANTS TO BE")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                                .tracking(2)
                            
                            Text("MILLIONAIRE?")
                                .font(.system(size: 42, weight: .heavy))
                                .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                                .tracking(3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(red: 0.95, green: 0.75, blue: 0.3), lineWidth: 3)
                                        .padding(.horizontal, -15)
                                        .padding(.vertical, -8)
                                )
                        }
                    }
                    .padding(.top, 40)
                    
                    // Play button
                    Button(action: {
                        soundPlayer.play()
                        showGame = true
                    }) {
                        Text("PLAY")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 220, height: 70)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(red: 0.9, green: 0.7, blue: 0.25),
                                        Color(red: 0.4, green: 0.5, blue: 0.7)
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(40)
                            .overlay(
                                RoundedRectangle(cornerRadius: 40)
                                    .stroke(Color(red: 0.6, green: 0.5, blue: 0.3), lineWidth: 3)
                            )
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    
                    // Navigation buttons
                    HStack(spacing: 50) {
                        NavigationButton(icon: "trophy.fill", label: "LEADERBOARD")
                        NavigationButton(icon: "gearshape.fill", label: "SETTINGS")
                        NavigationButton(icon: "questionmark.circle.fill", label: "HOW TO PLAY")
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                // Lifelines section
                VStack(spacing: 15) {
                    Text("LIFELINES")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
                        .tracking(2)
                    
                    HStack(spacing: 30) {
                        LifelineButton(type: "50:50", isAvailable: true)
                        LifelineButton(type: "audience", isAvailable: true)
                        LifelineButton(type: "expert", isAvailable: true)
                    }
                    .padding(.bottom, 40)
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color(red: 0.1, green: 0.15, blue: 0.25)
                        .opacity(0.6)
                )
            }
        }
    }
}

// Navigation button component
struct NavigationButton: View {
    let icon: String
    let label: String
    
    var body: some View {
        Button(action: {
            // Navigation action
        }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(.white)
                
                Text(label)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 90)
        }
    }
}

// Lifeline button component
struct LifelineButton: View {
    let type: String
    let isAvailable: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color(red: 0.95, green: 0.75, blue: 0.3),
                    lineWidth: 3
                )
                .frame(width: 60, height: 60)
            
            if type == "50:50" {
                Text("50:50")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
            } else if type == "audience" {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
            } else if type == "expert" {
                Image(systemName: "lightbulb.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color(red: 0.95, green: 0.75, blue: 0.3))
            }
        }
        .opacity(isAvailable ? 1.0 : 0.3)
    }
}

final class PlayButtonSoundPlayer {
    static let shared = PlayButtonSoundPlayer()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        loadSound()
    }
    
    private func loadSound() {
        guard let url = Bundle.main.url(forResource: "play", withExtension: "mp3") else {
            print("⚠️ play.mp3 not found in bundle.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
        } catch {
            print("⚠️ Failed to load play.mp3: \(error.localizedDescription)")
        }
    }
    
    func play() {
        if audioPlayer == nil {
            loadSound()
        }
        audioPlayer?.currentTime = 0
        audioPlayer?.play()
    }
}
