//
//  AudioPlayer.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 27/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation


class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
/* Here we have the recording functions
        -startPlayback (audio: URL)            -> Start to play the audio founded at the specified url
        -stopPlayback()                        -> Stop the player
        -audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)   ->
*/
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var audioPlayer: AVAudioPlayer!
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    func startPlayback (audio: URL) {
        let playbackSession = AVAudioSession.sharedInstance()
        do {
            try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch { print("Playing over the device's speakers failed") }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch { print("Playback failed.") }
    }
     
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
//----- delegate func avaudioplayer
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
    
}
