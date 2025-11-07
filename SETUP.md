# 🎮 Millionaires Culture - Setup Guide

## ⚠️ Important: Files Need to be Added to Xcode

The game files have been created, but Xcode doesn't know about them yet. Follow these steps to complete the setup:

---

## 📋 Quick Setup (5 minutes)

### Step 1: Open Xcode Project
- Double-click `Millionaires Culture.xcodeproj` to open in Xcode
- Wait for Xcode to load completely

### Step 2: Add New Files to Project

#### Option A: Drag and Drop (Easiest)
1. Open Finder and navigate to your project folder
2. Locate these three folders:
   - `Models/`
   - `ViewModels/`
   - `Views/`
3. In Xcode's left sidebar (Project Navigator), find the **blue** "Millionaires Culture" folder
4. Drag all three folders from Finder into Xcode, dropping them under "Millionaires Culture"
5. In the dialog that appears:
   - ✅ **Check** "Copy items if needed"
   - ✅ Select "Create groups" (NOT "Create folder references")
   - ✅ **Check** "Millionaires Culture" under "Add to targets"
   - Click **"Add"**

#### Option B: Using Xcode Menu
1. In Xcode, click **File → Add Files to "Millionaires Culture"...**
2. Navigate to your project's `Millionaires Culture` folder
3. Select the **Models** folder and click **"Add"**
4. Repeat for **ViewModels** and **Views** folders
5. Ensure options are set as in Option A

### Step 3: Verify Files Are Added
In Xcode's Project Navigator, you should now see:
```
Millionaires Culture
├── 📁 Models
│   └── Question.swift
├── 📁 ViewModels
│   └── GameViewModel.swift
├── 📁 Views
│   ├── GameView.swift
│   ├── MenuView.swift
│   └── PrizeLadderView.swift
├── ContentView.swift (updated)
├── Millionaires_CultureApp.swift
└── Assets.xcassets
```

### Step 4: Build and Run
1. Press **⌘ + B** (Command + B) to build
2. If build succeeds, press **⌘ + R** (Command + R) to run
3. The game should now launch! 🎉

---

## 🐛 Troubleshooting

### Error: "Type 'GameViewModel' does not conform to protocol 'ObservableObject'"
**Solution:** The files aren't added to the Xcode target yet. Complete Steps 1-3 above.

### Error: "Cannot find 'Question' in scope"
**Solution:** `Question.swift` isn't in the build target. Re-add the Models folder.

### Error: "Cannot find 'MenuView' in scope"
**Solution:** View files aren't in the build target. Re-add the Views folder.

### Files appear gray in Xcode
**Solution:** 
1. Select the gray file in Project Navigator
2. Open File Inspector (⌥⌘1 or View → Inspectors → File)
3. Under "Target Membership", check "Millionaires Culture"

### Clean Build if Issues Persist
1. **Product → Clean Build Folder** (⇧⌘K)
2. Close and reopen Xcode
3. Build again (⌘B)

---

## 🎯 What Each File Does

### Models/Question.swift
- Defines question structure
- Contains all 20 trivia questions
- Manages prize ladder ($100 to $1M)
- Defines safe levels

### ViewModels/GameViewModel.swift
- Game state management
- Lifeline logic (50:50, Expert, Audience)
- Answer checking
- Score tracking
- Win/lose conditions

### Views/MenuView.swift
- Main menu screen
- "WHO WANTS TO BE MILLIONAIRE?" title
- PLAY button
- Navigation buttons
- Lifelines preview

### Views/GameView.swift
- Main game interface
- Question display
- Answer options (A, B, C, D)
- Lifeline buttons
- Modal dialogs

### Views/PrizeLadderView.swift
- Prize ladder display
- Current position indicator
- Safe level highlighting
- "Retire" button

---

## 🎮 Game Features

✅ **15 Questions** per game (randomly selected)  
✅ **3 Lifelines** (each used once)  
✅ **Prize Ladder** from $100 to $1,000,000  
✅ **Safe Levels** at $1K, $32K, $1M  
✅ **Retire Option** to keep winnings  
✅ **Beautiful UI** with gold theme  
✅ **Animations** for correct/incorrect answers  
✅ **Responsive Layout** for iPhone & iPad  

---

## 📱 Running the Game

### On Simulator
1. Select a simulator from the device menu (top of Xcode)
2. Press ⌘R to run
3. Game launches automatically

### On Physical Device
1. Connect your iPhone/iPad
2. Select it from the device menu
3. Trust the developer certificate if prompted
4. Press ⌘R to run

---

## 🎨 Color Scheme

- **Gold**: #F2BF4D (primary accent)
- **Dark Blue**: #0D1A33 (background)
- **Card Background**: #1F1F1F
- **Correct Answer**: Green
- **Incorrect Answer**: Red

---

## 🔄 Next Steps After Setup

1. **Test the game** - Play through a full game
2. **Check animations** - Answer questions to see feedback
3. **Try lifelines** - Test each one works correctly
4. **Test on iPad** - See the horizontal layout
5. **Customize questions** - Add your own in Question.swift

---

## 📝 Need Help?

If you encounter issues:
1. Check the troubleshooting section above
2. Verify all files are added to the target
3. Clean build folder and rebuild
4. Restart Xcode

---

**Ready to play? Add the files to Xcode and start the game! 🎉**
