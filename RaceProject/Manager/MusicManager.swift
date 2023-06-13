//
//  MusicManager.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import Foundation
import AVFoundation

class MusicManager {
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        setupAudioPlayer()
    }
    
    private func setupAudioPlayer() {
        if let filePath = Bundle.main.path(forResource: "TokyoDrift", ofType: "mp3") {
            let url = URL(fileURLWithPath: filePath)
            
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
            } catch {
                print("Error initializing audio player: \(error.localizedDescription)")
            }
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}
