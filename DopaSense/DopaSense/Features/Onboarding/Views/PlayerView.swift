//
//  PlayerView.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import SwiftUI
import AVFoundation

struct PlayerView: UIViewRepresentable {

    let videoName: String
    let player: AVQueuePlayer

    func makeUIView(context: Context) -> UIView {
        LoopingPlayerUIView(
            videoName: videoName,
            player: player
        )
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

