//
//  LevelSelectionViewModel.swift
//  TuneIslan
//
//  Created by Apple Esprit on 12/11/2025.
//

import Foundation
import Combine

// MARK: - Level Model
struct Level: Identifiable {
    let id: Int
    let title: String
    let description: String
    let isUnlocked: Bool
}

// MARK: - Play Mode Enum
enum PlayMode {
    case appPiano
    case realPiano
}

// MARK: - Level Selection ViewModel
class LevelSelectionViewModel: ObservableObject {
    // Published properties for UI binding
    @Published var currentLevel: Level
    @Published var selectedPlayMode: PlayMode?
    @Published var showPianoView = false
    
    // All levels (can be expanded later)
    let allLevels: [Level] = [
        Level(id: 1, title: "Level 1: Basic Keys", description: "Learn Do-Re-Mi", isUnlocked: true),
        Level(id: 2, title: "Level 2: Simple Melodies", description: "Play your first song", isUnlocked: false),
        Level(id: 3, title: "Level 3: Chords", description: "Master basic chords", isUnlocked: false)
    ]
    
    init() {
        // Start with Level 1
        self.currentLevel = allLevels[0]
    }
    
    // MARK: - Methods
    func selectPlayMode(_ mode: PlayMode) {
        selectedPlayMode = mode
        
        // For now, only App Piano is implemented
        if mode == .appPiano {
            showPianoView = true
        } else {
            // Real Piano feature coming soon
            print("Real Piano feature will be implemented in next phase")
        }
    }
    
    func resetSelection() {
        selectedPlayMode = nil
        showPianoView = false
    }
}
