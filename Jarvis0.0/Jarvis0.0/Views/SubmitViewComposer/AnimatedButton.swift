//
//  AnimatedButton.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//


/*
 Here we have the Recording Button Animated
    -launch a recordingsession on the first push
    -stop it when we push again
    -restart the recordingsession
 */

import SwiftUI
struct AnimatedButton: View {
//--to help us create the wave around the recording button
    @State var animationAmount : CGFloat = 1
//--to use audioRecording and audioPlaying functions
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
//--to access an affect the properties of the reminder in the submitView
    @Binding var reminder: Reminder
    //boolean value to toggle the display of the different button through the user's needs
    @State var isRecording = false
    @State var recordIsPresent = false
    //set initial value pof the progress bar
    @State var value : CGFloat = 0
    @State var time : Int = 0
    
//--Start the timer
    func launchTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            print("plus 1")
            self.value += 0.023333333
            self.time += 1
            if self.time == 30 {
                print("it's over")
                timer.invalidate()
                self.resetTimer()
            }
        }
    }
//--Stop and reset the timer
    func resetTimer() {
        self.isRecording = false
        self.audioRecorder.stopRecording()
        self.time = 1
        self.value = 0
    }
    
    var body: some View {
        VStack {
            ZStack {
                ZStack {
                    HelpCircleView()
                        .animation(.spring())
                        .offset(y: self.isRecording ? -10 : 100)
                }
//--------------Progress View of the recording session for 30sec
                ProgressView(value: self.$value, time: self.$time)
                VStack {
//--------------Record Button if we are not recording and we don't have any records
                    if !recordIsPresent {
//                        if !isRecording {
                             /* Record button */
                            Image(systemName: "mic.circle")
                                .foregroundColor(.orange)
                                .font(.system(size: 100))
                                .padding()
                                .onLongPressGesture {
                                    self.reminder.fileURL = self.audioRecorder.startRecording()
                                    self.isRecording = true
                                    self.launchTimer()
                                }
                                .simultaneousGesture(
                                    DragGesture()
                                        .onEnded {_ in
                                            self.recordIsPresent = true
                                            self.time = 29
                                    }
                                )
//                                .onTapGesture {
//                                    self.reminder.fileURL = self.audioRecorder.startRecording()
//                                    self.isRecording = true
//                                    self.launchTimer()
//                                }
//                        } else {
//                            Button(action: {
//                                self.recordIsPresent = true
//                                self.time = 29
//                            }){
//                                Image(systemName: "stop.circle")
//                                    .foregroundColor(.orange)
//                                    .font(.system(size: 100))
//                                    .padding()
//                            }
//                        }
                    } else  {
                        Button(action: { self.audioPlayer.startPlayback(audio: self.reminder.fileURL!) }){
                            Image(systemName: "play.circle")
                                .foregroundColor(.orange)
                                .font(.system(size: 100))
                                .padding()
                        }
                    }
                }
//--------------Stroke to animate a wave around our button
                .overlay(
                    Circle()
                        .stroke(Color.orange)
                        .scaleEffect(self.recordIsPresent ? animationAmount - 0.4 : animationAmount - 0.8)
                        .opacity(Double(2 - animationAmount))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                )
                .onAppear(){ self.animationAmount = 2 }
//--------------Restart Btn to startOver and record something else
                if recordIsPresent && !isRecording {
                    Button(action: {
                        //erase the audio recorded
                        self.audioRecorder.deleteRecording(urlsToDelete: [self.reminder.fileURL!])
                        self.recordIsPresent = false
                        self.reminder.fileURL = nil
//                       //restart an audio
                        self.reminder.fileURL = self.audioRecorder.startRecording()
                        self.isRecording = true
                        self.launchTimer()
                    }) {
                        Image(systemName: "gobackward")
                            .foregroundColor(.orange)
                            .font(.system(size: 35))
                            .opacity(0.6)
                            .padding()
                    }
                    .offset(x: 135)
                }
            }
        }
        .onDisappear { self.time = 29 }
        .frame(height: 200)
    }
}




//@GestureState var isDetectingLongPress = false
//@State var completedLongPress = false
//var longPress: some Gesture {
//    LongPressGesture(minimumDuration: 30)
//        .onChanged({_ in
//            print("longpress detected")
//            self.reminder.fileURL = self.audioRecorder.startRecording()
//            self.isRecording = true
//            self.launchTimer()
//        })
//        .updating($isDetectingLongPress) { currentstate, gestureState,
//                transaction in
//            gestureState = currentstate
//            transaction.animation = Animation.easeIn(duration: 1.0)
//        }
//        .onEnded { finished in
//            self.completedLongPress = finished
//            print("-------start recording-------")
//        }
//}
