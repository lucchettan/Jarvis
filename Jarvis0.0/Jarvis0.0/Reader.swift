//
//  Reader.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 24/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import AVFoundation


class Reader {
    
    func stringReader(string: String) {
        
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
//        utterance.rate = 0.1

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        
    }
    
    
}
