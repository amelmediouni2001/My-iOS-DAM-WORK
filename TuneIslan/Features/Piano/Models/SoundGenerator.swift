//
//  SoundGenerator.swift
//  TuneIsland
//
//  FIXED VERSION - Correct audio format matching
//

import Foundation
import AVFoundation

class SoundGenerator {
    private let engine = AVAudioEngine()
    private let playerNode = AVAudioPlayerNode()
    
    // CRITICAL: Use the SAME format everywhere
    private let audioFormat: AVAudioFormat
    
    init() {
        // Get the output format from the main mixer
        let mainMixer = engine.mainMixerNode
        let outputFormat = mainMixer.outputFormat(forBus: 0)
        
        // Create our format matching the output
        // Use the SAME sample rate and channel count as the output
        guard let format = AVAudioFormat(
            standardFormatWithSampleRate: outputFormat.sampleRate,
            channels: outputFormat.channelCount
        ) else {
            fatalError("Cannot create audio format")
        }
        
        self.audioFormat = format
        
        // Setup audio session for playback
        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
        } catch {
            print("❌ Audio session error: \(error)")
        }
        
        // Attach and connect with the SAME format
        engine.attach(playerNode)
        engine.connect(playerNode, to: mainMixer, format: audioFormat)
        
        // Start engine
        do {
            try engine.start()
        } catch {
            print("❌ Engine start error: \(error)")
        }
    }
    
    // Play a note with given frequency
    func playNote(frequency: Double, duration: Double = 0.5) {
        let sampleRate = audioFormat.sampleRate
        let channelCount = Int(audioFormat.channelCount)
        let frameCount = AVAudioFrameCount(sampleRate * duration)
        
        // Create buffer with the SAME format
        guard let buffer = AVAudioPCMBuffer(
            pcmFormat: audioFormat,
            frameCapacity: frameCount
        ) else {
            print("❌ Cannot create buffer")
            return
        }
        
        buffer.frameLength = frameCount
        
        // Generate waveform for each channel
        for channel in 0..<channelCount {
            guard let data = buffer.floatChannelData?[channel] else { continue }
            
            for frame in 0..<Int(frameCount) {
                let time = Double(frame) / sampleRate
                
                // Sine wave with envelope
                let amplitude = Float(sin(2.0 * .pi * frequency * time))
                let envelope = Float(exp(-time * 3.0))
                
                data[frame] = amplitude * envelope * 0.25
            }
        }
        
        // Schedule and play
        playerNode.scheduleBuffer(buffer, completionHandler: nil)
        
        if !playerNode.isPlaying {
            playerNode.play()
        }
    }
    
    // Stop all sounds
    func stop() {
        playerNode.stop()
    }
    
    // Cleanup
    deinit {
        playerNode.stop()
        engine.stop()
    }
}
