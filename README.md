# Millionaires Culture - Who Wants to Be a Millionaire?

A SwiftUI implementation of the classic "Who Wants to Be a Millionaire?" game show with culture and general knowledge questions.

## Features

### Game Mechanics
- **15 Questions**: Answer 15 progressively difficult questions to win $1,000,000
- **Prize Ladder**: Fixed prize amounts from $100 to $1,000,000
- **Safe Levels**: Guaranteed prizes at $1,000, $32,000, and $1,000,000
- **Retire Option**: Cash out at any time with your current safe prize

### Three Lifelines
1. **50:50**: Eliminates two incorrect answers
2. **Expert Advice**: Provides a helpful hint about the question
3. **Audience Poll**: Shows simulated audience voting percentages

### Visual Features
- **Dark premium theme** with golden accents
- **Animated answer feedback** (correct = green, incorrect = red)
- **Dynamic prize ladder** that highlights current position
- **Responsive layout** for both iPhone and iPad
- **Modal dialogs** for game feedback and lifeline information

## Project Structure

```
Millionaires Culture/
├── Models/
│   └── Question.swift              # Question data model and pool
├── ViewModels/
│   └── GameViewModel.swift         # Game logic and state management
├── Views/
│   ├── MenuView.swift              # Main menu screen
│   ├── GameView.swift              # Main game interface
│   └── PrizeLadderView.swift      # Prize ladder component
├── ContentView.swift               # Root navigation view
└── Millionaires_CultureApp.swift  # App entry point
```

## Game Flow

1. **Menu Screen**: Shows title, PLAY button, navigation options, and lifelines preview
2. **Game Screen**: 
   - Question display with current prize
   - Four answer options (A, B, C, D)
   - Three lifelines at the top
   - Prize ladder on the side (iPad) or top (iPhone)
   - Retire button
3. **Answer Feedback**: Visual animation showing correct/incorrect answer
4. **Game Over/Win**: Modal showing final results with option to play again

## How to Play

1. Tap **PLAY** to start a new game
2. Read the question and select one of four answers
3. Use lifelines strategically (each can only be used once)
4. Advance through all 15 questions to win $1,000,000
5. Or tap "Retire" to keep your safe prize and start over

## Technical Details

- **SwiftUI** for all UI components
- **ObservableObject** pattern for state management
- **Animations** using SwiftUI's built-in animation system
- **Responsive design** with GeometryReader for adaptive layouts
- **Random question selection** from a pool of 20+ questions
- **Safe level tracking** for guaranteed prizes

## Color Palette

- **Primary Gold**: RGB(0.95, 0.75, 0.3) - #F2BF4D
- **Secondary Gold**: RGB(0.8, 0.6, 0.2) - #CC9933
- **Dark Background**: RGB(0.05, 0.1, 0.2) - #0D1A33
- **Card Background**: RGB(0.12, 0.12, 0.12) - #1F1F1F

## Future Enhancements

- Leaderboard functionality
- Settings (sound, difficulty)
- How to Play instructions
- Multiple question categories
- Multiplayer mode
- Sound effects and music
- Haptic feedback

---

Created with ❤️ using SwiftUI
