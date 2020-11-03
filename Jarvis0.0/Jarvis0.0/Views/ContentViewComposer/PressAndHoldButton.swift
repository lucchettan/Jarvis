//
//  PressAndHoldButton.swift
//  Jarvis0.0
//
//  Created by mac on 27/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct PressAndHoldButton: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @State var tapStatus = ""
    @State var isClicked = false
    @State var longPressDetected = false
    
    @Binding var reminder : Reminder
    @Binding var showModal : Bool
    @Binding var showPleaseHoldToRecordModal : Bool

    
    var body: some View {
        Button(action: {
            if self.longPressDetected {
                print("I'm in the end of the Long press gesture")

                isClicked = false
                longPressDetected = false
                // 2-  Exectued at the end of a long press detected only.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.audioRecorder.stopRecording()
                }
                self.showModal.toggle()
            } else {
                print("I'm in the simple tap gesture")

                // Exectued after a simple Tap detected.
                self.showPleaseHoldToRecordModal = true
            }
        }) {
            ZStack{
                //The animation will be displayed only while isClicked is true
                if isClicked { RoundAnimation() }
                
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.pink)
                    .background(Circle().frame(width: 55, height: 55).foregroundColor(Color(UIColor.systemBackground)).shadow(radius: 8))
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.07).onEnded({ _ in
                
                print("I'm in the sumultaneous long press ")
                //1- Those action will be triggered when the hold is detected.
                self.reminder.fileURL = self.audioRecorder.startRecording()
                isClicked = true
                longPressDetected = true
                self.showPleaseHoldToRecordModal = false

            })
        )
    }
}

//struct PressAndHoldButton_Previews: PreviewProvider {
//    static var previews: some View {
//        PressAndHoldButton()
//    }
//}
