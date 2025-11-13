//
//  PianoView.swift
//  TuneIsland
//
//  Page principale du piano - Level 1
//  Created by Apple Esprit on 13/11/2025
//

import SwiftUI

struct PianoView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: PianoViewModel
    
    // Initialisation avec le niveau
    init(level: Int) {
        _viewModel = StateObject(wrappedValue: PianoViewModel(level: level))
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background gradient
                backgroundLayer
                
                VStack(spacing: 0) {
                    // HEADER: Barre du haut avec retour et titre
                    headerBar
                        .padding(.top, 30)
                    
                    Spacer()
                    
                    // CHARACTER: Batman (placeholder pour l'instant)
                    characterSection
                    
                    Spacer()
                    
                    // PIANO KEYBOARD: Le clavier interactif
                    PianoKeyboardView(keys: viewModel.keys) { key in
                        viewModel.playKey(key)
                    }
                    .padding(.bottom, 50)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarHidden(true)
        .statusBar(hidden: true)
    }
    
    // MARK: - Background Layer
    private var backgroundLayer: some View {
        LinearGradient(
            colors: [
                Color(red: 0.4, green: 0.6, blue: 0.9),
                Color(red: 0.6, green: 0.4, blue: 0.8)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: - Header Bar
    private var headerBar: some View {
        HStack(spacing: 20) {
            // Bouton retour
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack(spacing: 10) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 24, weight: .bold))
                    Text("Retour")
                        .font(.system(size: 20, weight: .semibold))
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color.black.opacity(0.3))
                )
            }
            
            Spacer()
            
            // Titre du niveau
            VStack(spacing: 4) {
                Text("Niveau \(viewModel.currentLevel)")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("Touches de Base")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // Espace pour équilibrer (optionnel: ajouter un bouton info plus tard)
            Color.clear
                .frame(width: 120)
        }
        .padding(.horizontal, 30)
    }
    
    // MARK: - Character Section
    private var characterSection: some View {
        VStack(spacing: 15) {
            // Speech bubble
            Text("Joue les notes que je te montre!")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 25)
                .padding(.vertical, 15)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                )
            
            // Character placeholder (remplace avec ton image Batman plus tard)
            ZStack {
                Circle()
                    .fill(Color.black.opacity(0.3))
                    .frame(width: 180, height: 180)
                
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white.opacity(0.8))
            }
            .shadow(color: .black.opacity(0.3), radius: 15, x: 0, y: 8)
        }
    }
}

// MARK: - Preview
struct PianoView_Previews: PreviewProvider {
    static var previews: some View {
        PianoView(level: 1)
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
