//
//  AnimatedButton.swift
//  Jarvis0.0
//
//  Created by Florent Frossard on 26/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct AnimatedButton: View {
    
    @State var animationAmount : CGFloat = 1
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    
    var body: some View {
        
        NavigationView{
            VStack {
                
                RecordingList(audioRecorder: audioRecorder)
                
                if audioRecorder.recording == false {
                    Button(action: {self.audioRecorder.startRecording()}) {
                        Image(systemName: "mic")
                                        
                            }.padding(50)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                .stroke(Color.red)
                                .scaleEffect(animationAmount)
                                .opacity(Double(2 - animationAmount))
                                .animation(Animation.easeInOut(duration: 1)
                                .repeatForever(autoreverses: false))
                            ).onAppear() {
                                self.animationAmount = 2
                            }
                    } else {
                    
                    Button(action: {self.audioRecorder.stopRecording()}) {
                                      Image(systemName: "stop.fill")
                            }.padding(50)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                        }
                    }.navigationBarTitle("Voice Record")
                .navigationBarItems(trailing: EditButton())
                }
            }
        }

struct AnimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedButton(audioRecorder: AudioRecorder())
    }
}
