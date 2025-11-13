//
//  PianoViewModel.swift
//  TuneIsland
//
//  Created by Apple Esprit on 13/11/2025
//

import Foundation
import Combine
import SwiftUI

class PianoViewModel: ObservableObject {
    // Les touches actuellement affichées
    @Published var keys: [PianoKey] = []
    
    // Le niveau actuel
    @Published var currentLevel: Int = 1
    
    // Générateur de son
    private let soundGenerator = SoundGenerator()
    
    // Initialisation avec un niveau
    init(level: Int) {
        self.currentLevel = level
        loadKeysForLevel(level)
    }
    
    // Charger les touches selon le niveau
    func loadKeysForLevel(_ level: Int) {
        switch level {
        case 1:
            keys = generateLevel1Keys()
        case 2:
            keys = generateLevel2Keys()
        case 3:
            keys = generateLevel3Keys()
        default:
            keys = generateLevel1Keys()
        }
    }
    
    // Jouer une touche
    func playKey(_ key: PianoKey) {
        soundGenerator.playNote(frequency: key.frequency, duration: 0.8)
        print("🎹 Note jouée: \(key.note) à \(key.frequency) Hz")
    }
    
    // MARK: - Génération des touches par niveau
    
    // Level 1: Gamme complète Do → Si (7 touches)
    private func generateLevel1Keys() -> [PianoKey] {
        return [
            PianoKey(
                note: "Do",
                octave: 4,
                type: .white,
                frequency: 261.63,
                color: Color(red: 1.0, green: 0.3, blue: 0.3) // Rouge
            ),
            PianoKey(
                note: "Ré",
                octave: 4,
                type: .white,
                frequency: 293.66,
                color: Color.orange // Orange
            ),
            PianoKey(
                note: "Mi",
                octave: 4,
                type: .white,
                frequency: 329.63,
                color: Color.yellow // Jaune
            ),
            PianoKey(
                note: "Fa",
                octave: 4,
                type: .white,
                frequency: 349.23,
                color: Color.green // Vert
            ),
            PianoKey(
                note: "Sol",
                octave: 4,
                type: .white,
                frequency: 392.00,
                color: Color.cyan // Cyan
            ),
            PianoKey(
                note: "La",
                octave: 4,
                type: .white,
                frequency: 440.00,
                color: Color.blue // Bleu
            ),
            PianoKey(
                note: "Si",
                octave: 4,
                type: .white,
                frequency: 493.88,
                color: Color.purple // Violet
            )
        ]
    }
    
    // Level 2: Gamme complète avec octave supérieure (pour plus tard)
    private func generateLevel2Keys() -> [PianoKey] {
        var keys = generateLevel1Keys()
        keys.append(PianoKey(
            note: "Do",
            octave: 5,
            type: .white,
            frequency: 523.25,
            color: Color(red: 1.0, green: 0.5, blue: 0.5)
        ))
        return keys
    }
    
    // Level 3: Gamme complète avec dièses (pour plus tard)
    private func generateLevel3Keys() -> [PianoKey] {
        return generateLevel1Keys()
    }
    
    // Nettoyage
    deinit {
        soundGenerator.stop()
    }
}
