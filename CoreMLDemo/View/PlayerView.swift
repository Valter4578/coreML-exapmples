//
//  PlayerView.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 13.11.2019.
//  Copyright © 2019 Максим Алексеев. All rights reserved.
//

import AVFoundation
import UIKit

class PlayerView: UIView {
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    
    func setPlayerURL(url: URL) {
        player = AVPlayer(url: url)
        player.allowsExternalPlayback = true
        
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.bounds
    }

}
