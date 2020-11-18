//
//  ModifyAudioPressAndHold.swift
//  Jarvis0.0
//
//  Created by mac on 09/11/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI
//This Press and Hold is to use in the DateASelectionModal -> To rewrite an existing audio Url
struct ModifyAudioPressAndHold: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @State var tapStatus = ""
    @State var isClicked = false
    @State var longPressDetected = false
    
    @Binding var reminder : Reminder
    @Binding var showPleaseHoldToRecordModal : Bool
    @Binding var recordIsPresent : Bool

    
    var body: some View {
        Button(action: {
            // 2-  Exectued at the end of a long press detected only.
            if self.longPressDetected {
                isClicked = false
                longPressDetected = false
                self.recordIsPresent = true
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.audioRecorder.stopRecording()
//                }
            } else {
                // Exectued after a simple Tap detected.
                self.showPleaseHoldToRecordModal = true
            }
        }) {
            ZStack{
                //The animation will be displayed only while isClicked is true
                if isClicked { RoundAnimation() }
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .frame(width: 85, height: 85)
                    .foregroundColor(.pink)
                    .background(Circle().frame(width: 85, height: 85).foregroundColor(Color(UIColor.systemBackground)).shadow(radius: 8))
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.07).onEnded({ _ in
                //1- Those action will be triggered when the hold is detected.
                self.reminder.fileURL = self.audioRecorder.startRecording()
                isClicked = true
                longPressDetected = true
                self.showPleaseHoldToRecordModal = false
                simpleSuccess()
            })
        )
    }

    func simpleSuccess() {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(.success)
    }
}
