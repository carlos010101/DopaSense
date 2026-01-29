//
//  LoopingPlayerUIView.swift
//  DopaSense
//
//  Created by Administrador on 1/16/26.
//

import UIKit
import AVFoundation

final class LoopingPlayerUIView: UIView {

    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?

    init(
        videoName: String,
        player: AVQueuePlayer,
        videoGravity: AVLayerVideoGravity = .resizeAspectFill
    ) {
        super.init(frame: .zero)

        guard let url = Bundle.main.url(
            forResource: videoName,
            withExtension: "mp4"
        ) else {
            fatalError("Video not found: \(videoName).mp4")
        }

        let asset = AVURLAsset(url: url)
        let item = AVPlayerItem(asset: asset)

        player.isMuted = true
        playerLayer.player = player
        playerLayer.videoGravity = videoGravity

        layer.addSublayer(playerLayer)

        playerLooper = AVPlayerLooper(player: player, templateItem: item)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
