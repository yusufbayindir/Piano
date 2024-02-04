//
//  ViewController.swift
//  Piano
//
//  Created by Yusuf Bayindir on 1/24/24.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var audioPlayers: [Int: [AVAudioPlayer]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Preload all the audio players
        for i in 0..<24 {
            preloadAudioPlayers(forIndex: i)
        }
    }
    
    func preloadAudioPlayers(forIndex index: Int) {
        let soundName = "key\(index+1)" // Assuming your sounds are named sequentially
        var players: [AVAudioPlayer] = []
        for _ in 0..<10 { // Prepare 10 instances to allow for overlap
            if let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
                do {
                    let player = try AVAudioPlayer(contentsOf: soundURL)
                    player.prepareToPlay() // Preloads buffer and prepares the audio for playing
                    players.append(player)
                } catch {
                    print("Error loading \(soundName): \(error)")
                }
            }
        }
        audioPlayers[index] = players
    }
    
    func playSound(forIndex index: Int) {
        if let players = audioPlayers[index] {
            for player in players {
                if !player.isPlaying {
                    player.currentTime = 0 // Rewind to the start
                    player.play()
                    break
                }
            }
        }
    }
    
    @IBAction func pianoButtonTapped(_ sender: UIButton) {
        let soundIndex = sender.tag
        playSound(forIndex: soundIndex)
        //Reduces the sender's (the button that got pressed) opacity to half.
        sender.alpha = 0.5
        
        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
        
        
        
    }
}
