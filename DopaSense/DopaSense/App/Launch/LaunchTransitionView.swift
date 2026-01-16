//
//  LaunchTransitionView.swift
//  DopaSense
//
//  Created by Administrador on 1/14/26.
//

import SwiftUI

struct LaunchTransitionView<Content: View>: View {
    @State private var scale: CGFloat = 1.0
    @State private var opacity: Double = 1.0
    @State private var showNext = false

    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ZStack {
            if showNext {
                content
            } else {
                launchView
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    private var launchView: some View {
        ZStack {
            DSColor.backgroundPrimary
                .ignoresSafeArea()

            Image("LogoLaunch")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .scaleEffect(scale)
                .opacity(opacity)
        }
        .ignoresSafeArea()
    }

    private func startAnimation() {
        // Respiración 1 – In
        withAnimation(.easeInOut(duration: 0.7)) {
            scale = 1.025
        }

        // Respiración 1 – Out
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.7)) {
                scale = 1.0
            }
        }

        // Respiración 2 – In
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            withAnimation(.easeInOut(duration: 0.7)) {
                scale = 1.035
            }
        }

        // Respiración 2 – Out
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.1) {
            withAnimation(.easeInOut(duration: 0.7)) {
                scale = 1.0
            }
        }

        // Fade out
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            withAnimation(.easeOut(duration: 0.4)) {
                opacity = 0
            }
        }

        // Transición a Home
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.4) {
            showNext = true
        }
    }

}

#Preview {
    LaunchTransitionView {
        ZStack {
            Color.gray.ignoresSafeArea()
            Text("Home Screen")
                .font(.largeTitle)
                .foregroundStyle(.white)
        }
    }
}
