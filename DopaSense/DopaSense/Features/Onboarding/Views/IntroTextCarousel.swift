//
//  IntroTextCarousel.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI

struct IntroTextCarousel: View {
    let slides: [IntroSlide]
    @State private var index = 0

    var body: some View {
        VStack(spacing: 12) {

            TabView(selection: $index) {
                ForEach(Array(slides.enumerated()), id: \.offset) { i, slide in
                    Text(slide.title)
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .tag(i)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)

            // Dots
            HStack(spacing: 8) {
                ForEach(0..<slides.count, id: \.self) { i in
                    Circle()
                        .fill(i == index ? Color.white : Color.white.opacity(0.4))
                        .frame(width: 8, height: 8)
                }
            }
        }
    }
}
