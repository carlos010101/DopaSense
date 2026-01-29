//
//  IntroView.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI

struct IntroView: View {
    
    let introSlides: [IntroSlide] = [
        .init(title: "Una relación más consciente con tu teléfono."),
        .init(title: "Recupera espacio para lo que importa."),
        .init(title: "Reflexiones que se adaptan a ti.")
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                IntroBackgroundVideoView(videoName: "Dopasense_Intro")

                BottomOverlay()
                
                VStack(spacing: 24) {
                    Spacer()
                    IntroTextCarousel(slides: introSlides)
                    IntroAuthView()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    IntroView()
}
