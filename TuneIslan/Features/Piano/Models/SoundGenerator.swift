//
//  SoundGenerator.swift
//  TuneIsland
//
//  VERSION WITH AUDIO FILES (Most Reliable)
//

import Foundation
import AVFoundation

class SoundGenerator {
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    
    init() {
        // Setup audio session
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("❌ Audio session error: \(error)")
        }
        
        // Preload all piano sounds
        preloadSounds()
    }
    
    // Preload audio files for better performance
    private func preloadSounds() {
        let notes = ["do", "re", "mi", "fa", "sol", "la", "si"]
        
        for note in notes {
            if let path = Bundle.main.path(forResource: note, ofType: "mp3") {
                let url = URL(fileURLWithPath: path)
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.prepareToPlay()
                    player.volume = 0.8
                    audioPlayers[note] = player
                    print("✅ Loaded: \(note).mp3")
                } catch {
                    print("❌ Cannot load \(note).mp3: \(error)")
                }
            } else {
                print("⚠️ File not found: \(note).mp3")
            }
        }
    }
    
    // Play a note by name (do, re, mi, etc.)
    func playNote(noteName: String) {
        let normalizedNote = noteName.lowercased()
        
        guard let player = audioPlayers[normalizedNote] else {
            print("❌ No audio player for: \(noteName)")
            return
        }
        
        // Reset to beginning if already playing
        player.currentTime = 0
        player.play()
        print("🎹 Playing: \(noteName)")
    }
    
    // Play note by frequency (for backward compatibility)
    func playNote(frequency: Double, duration: Double = 0.5) {
        // Map frequency to note name
        let noteMap: [Double: String] = [
            261.63: "do",
            293.66: "re",
            329.63: "mi",
            349.23: "fa",
            392.00: "sol",
            440.00: "la",
            493.88: "si"
        ]
        
        // Find closest frequency
        if let noteName = noteMap[frequency] {
            playNote(noteName: noteName)
        }
    }
    
    // Stop all sounds
    func stop() {
        audioPlayers.values.forEach { $0.stop() }
    }
}
