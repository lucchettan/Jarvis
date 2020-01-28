//
//  AnimatedButton.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//


/*
 Here we have the Recording Button Animated that launch a recording session when we first push and stop it when we push again
 */
import SwiftUI
struct AnimatedButton: View {
    @State var animationAmount : CGFloat = 1
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    @Binding var reminder: Reminder
    @State var recordIsPresent = false
    
    var body: some View {
        VStack {
//          RecordingList(audioRecorder: audioRecorder)
            
            if self.recordIsPresent {
//-------------We display a play button to let him hear what he has recorded
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.reminder.fileURL!)
                }) {
                    Text("Play")
                }
//--------------And a Delete Btn to startOver and record something else
                Button(action: {
                    self.audioRecorder.deleteRecording(urlsToDelete: [self.reminder.fileURL!])
                    self.recordIsPresent = false
                }) {
                    Text("Delete")
                }
//----------Other Wise, in order to record something for the reminder
            } else {
                if audioRecorder.recording == false {
//------------------We display a MicroButton to start recording something
                    Button(action: {
                        self.reminder.fileURL = self.audioRecorder.startRecording()
                    }){
                        Image(systemName: "mic")
                    }
                        .padding(50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .overlay(Circle()
                            .stroke(Color.red)
                            .scaleEffect(animationAmount)
                            .opacity(Double(2 - animationAmount))
                            .animation(Animation.easeInOut(duration: 1)
                            .repeatForever(autoreverses: false))
                        ).onAppear(){ self.animationAmount = 2 }
                } else {
//------------------Once he is recording we display a stop button to endup the recording session
//------------------That should be replaced by a playbutton to let him hear what he just recorded 
                    Button(action: {
                        self.audioRecorder.stopRecording()
                        self.recordIsPresent = true
                    }){
                        Image(systemName: "stop.fill")
                    }
                        .padding(50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
        }
    }
}
