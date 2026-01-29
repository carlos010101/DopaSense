//
//  BackgroundVideoView.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI
import AVFoundation

struct IntroBackgroundVideoView: View {

    @State private var player = AVQueuePlayer()
    private let videoName: String

    init(videoName: String) {
        self.videoName = videoName
    }

    var body: some View {
        ZStack {
            PlayerView(videoName: videoName, player: player)
                .ignoresSafeArea()

            // Overlay oscuro inferior (tipo Life360)
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.65)
                ]),
                startPoint: .center,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
        .onAppear {
            player.play()
        }
        .onDisappear {
            player.pause()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.willResignActiveNotification
        )) { _ in
            player.pause()
        }
        .onReceive(NotificationCenter.default.publisher(
            for: UIApplication.didBecomeActiveNotification
        )) { _ in
            player.play()
        }
    }
}
