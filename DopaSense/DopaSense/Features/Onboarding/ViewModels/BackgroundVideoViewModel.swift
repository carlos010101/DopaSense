//
//  BackgroundVideoViewModel.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import AVFoundation
import Combine

final class BackgroundVideoViewModel: ObservableObject {

    let player: AVPlayer

    init(videoName: String) {
        guard let url = Bundle.main.url(forResource: videoName, withExtension: "mp4") else {
            fatalError("Video not found: \(videoName).mp4")
        }

        self.player = AVPlayer(url: url)
        self.player.isMuted = true
        self.player.actionAtItemEnd = .none

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loopVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem
        )
    }

    func play() {
        player.play()
    }

    func pause() {
        player.pause()
    }

    @objc private func loopVideo() {
        player.seek(to: .zero)
        player.play()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
