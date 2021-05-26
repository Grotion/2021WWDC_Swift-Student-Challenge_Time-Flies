//
//  SoundPlayer.swift
//  TimeFlies
//
//  Created by Shaun Ku on 2021/4/10.
//

import AVFoundation
extension AVPlayer{
    //Background
    static var shQueuePlayer = AVQueuePlayer()
    static var shPlayerLooper: AVPlayerLooper!
    static func setupSoundHint(volume: Float){
        guard let url = Bundle.main.url(forResource: "Ticking clock  Sound Effect", withExtension: "mp3")
        else{
            fatalError("Failed to find sound file.")
        }
        let item = AVPlayerItem(url: url)
        shQueuePlayer.volume = volume
        shPlayerLooper = AVPlayerLooper(player: shQueuePlayer, templateItem: item)
    }
    static let sharedTickTockPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "Ticking clock  Sound Effect", withExtension:"mp3")
        else{
            fatalError("Failed to find sound file.")
        }
        return AVPlayer(url: url)
    }()

    func playFromStart(){
        seek(to: .zero)
        play()
    }
}
