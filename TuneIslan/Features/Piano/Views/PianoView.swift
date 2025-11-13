//
//  PianoView.swift
//  TuneIsland
//
//  Piano Page - Level 1 (UPDATED: English + bg_level1 + Better Layout)
//  Created by Apple Esprit on 13/11/2025
//

import SwiftUI

struct PianoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: PianoViewModel
    
    // States for score and stars (to implement later)
    @State private var stars: Int = 0
    @State private var maxStars: Int = 3
    @State private var score: Int = 0
    
    // Initialization with level
    init(level: Int) {
        _viewModel = StateObject(wrappedValue: PianoViewModel(level: level))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background image (bg_level1)
                backgroundLayer
                
                VStack(spacing: 0) {
                    // HEADER: Top bar with stars, title, and score
                    enhancedHeaderBar
                        .padding(.top, 20)
                    
                    Spacer().frame(height: 40)
                    
                    // CHARACTER: Batman with spotlight
                    characterWithSpotlight
                    
                    Spacer()
                    
                    // PIANO KEYBOARD: Interactive keyboard (pushed to bottom)
                    PianoKeyboardView(keys: viewModel.keys) { key in
                        viewModel.playKey(key)
                    }
                    .padding(.bottom, 30)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
    
    // MARK: - Background Layer (bg_level1 Image)
    private var backgroundLayer: some View {
        GeometryReader { geo in
            Image("bg_level1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .overlay(
                    // Slight dark overlay for better readability
                    Color.black.opacity(0.2)
                )
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Enhanced Header Bar (Centered Title)
    private var enhancedHeaderBar: some View {
        ZStack {
            // CENTER: Level Title with Ribbon
            levelRibbon
            
            HStack {
                // LEFT: Back Button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding(.leading, 30)
                
                Spacer()
                
                // RIGHT: Stars and Score
                rightInfoPanel
                    .padding(.trailing, 30)
            }
        }
    }
    
    // MARK: - Level Ribbon (Center)
    private var levelRibbon: some View {
        ZStack {
            // Ribbon background
            HStack(spacing: 0) {
                // Left torn edge
                Image(systemName: "triangle.fill")
                    .rotationEffect(.degrees(90))
                    .foregroundColor(Color(red: 0.8, green: 0.15, blue: 0.2))
                    .frame(width: 10)
                    .offset(x: 5)
                
                // Main ribbon
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.95, green: 0.25, blue: 0.3),
                                Color(red: 0.85, green: 0.15, blue: 0.2)
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 55)
                
                // Right torn edge
                Image(systemName: "triangle.fill")
                    .rotationEffect(.degrees(-90))
                    .foregroundColor(Color(red: 0.8, green: 0.15, blue: 0.2))
                    .frame(width: 10)
                    .offset(x: -5)
            }
            .shadow(color: .black.opacity(0.5), radius: 8, x: 0, y: 4)
            
            // Text content
            HStack(spacing: 8) {
                Text("Level 1:")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white.opacity(0.95))
                
                Text("Basic Keys")
                    .font(.system(size: 22, weight: .heavy))
                    .foregroundColor(.white)
            }
            .shadow(color: .black.opacity(0.6), radius: 2, x: 0, y: 1)
        }
        .frame(maxWidth: 280)
    }
    
    // MARK: - Right Info Panel (Stars + Score + Badge)
    private var rightInfoPanel: some View {
        HStack(spacing: 20) {
            // Stars display
            HStack(spacing: 5) {
                ForEach(0..<maxStars, id: \.self) { index in
                    Image(systemName: index < stars ? "star.fill" : "star")
                        .font(.system(size: 28))
                        .foregroundColor(index < stars ? .yellow : .white.opacity(0.4))
                        .shadow(color: .black.opacity(0.4), radius: 3, x: 0, y: 2)
                }
                
                Text("\(stars)/\(maxStars)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 5)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.6))
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
            )
            
            // Batman Badge with Score
            HStack(spacing: 10) {
                // Batman icon placeholder
                ZStack {
                    Circle()
                        .fill(Color.yellow.opacity(0.95))
                        .frame(width: 45, height: 45)
                    
                    // Bat symbol (simple version)
                    Image(systemName: "moonphase.waxing.crescent.inverse")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                }
                .shadow(color: .yellow.opacity(0.5), radius: 8, x: 0, y: 0)
                .shadow(color: .black.opacity(0.4), radius: 5, x: 0, y: 3)
                
                // Score
                Text("\(score)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(Color.black.opacity(0.6))
                    .overlay(
                        Capsule()
                            .stroke(Color.white.opacity(0.3), lineWidth: 2)
                    )
            )
        }
    }
    
    // MARK: - Character with Spotlight (Batman)
    private var characterWithSpotlight: some View {
        ZStack {
            // Bat-Signal spotlight effect
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.yellow.opacity(0.5),
                            Color.yellow.opacity(0.25),
                            Color.yellow.opacity(0.1),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 30,
                        endRadius: 180
                    )
                )
                .frame(width: 360, height: 360)
                .blur(radius: 10)
            
            // Inner glow
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            Color.yellow.opacity(0.6),
                            Color.clear
                        ],
                        center: .center,
                        startRadius: 10,
                        endRadius: 120
                    )
                )
                .frame(width: 240, height: 240)
            
            // Batman Character
            Image("level_1")
                .resizable()
                .scaledToFit()
                .frame(width: 240, height: 240)
                .shadow(color: .black.opacity(0.5), radius: 15, x: 0, y: 8)
        }
    }
}

// MARK: - Preview
//struct PianoView_Previews: PreviewProvider {
//    static var previews: some View {
//        PianoView(level: 1)
//            .previewInterfaceOrientation(.landscapeLeft)
//    }
//}
