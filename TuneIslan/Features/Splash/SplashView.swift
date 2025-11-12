//
//  SplashView.swift
//  TuneIslan
//
//  Created by Apple Esprit on 12/11/2025.
//

//import Foundation
import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    
    var body: some View {
        if isActive {
            // Navigate to Level Selection
            LevelSelectionView()
        } else {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.8), Color.purple.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Cat Logo
                    Image("cat_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .scaleEffect(scale)
                        .opacity(opacity)
                    
                    // App Name
                    Text("TuneIsland")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(.white)
                        .opacity(opacity)
                    
                    Text("Learn Piano with Heroes!")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .opacity(opacity)
                }
            }
            .onAppear {
                // Animate logo
                withAnimation(.easeOut(duration: 1.0)) {
                    scale = 1.0
                    opacity = 1.0
                }
                
                // Navigate after 2.5 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

