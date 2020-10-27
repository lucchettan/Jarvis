//
//  AudioRec.swift
//  Jarvis0.0
//
//  Created by Florent on 27/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation


class AudioRec: ObservableObject {
  @Published var recording = false
  var audioRecorder: AVAudioRecorder!
}
