//
//  Reader.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 24/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import AVFoundation

//This read a styring vocally, we may not use it anymore but this piece of code could be usefull further
class Reader {
    func stringReader(string: String) -> NSCoder {
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: Locale.current.identifier)
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
        return NSCoder()
    }
}
