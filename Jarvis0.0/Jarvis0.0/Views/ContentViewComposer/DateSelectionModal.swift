//
//  modalDateSelection.swift
//  Jarvis0.0
//
//  Created by mac on 27/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct DateSelectionModal: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
    @State var showPleaseHoldToRecordModal = false
    @State var recordIsPresent = true
    @Binding var showModal: Bool
    @Binding var reminders: [Reminder]
    @Binding var reminder : Reminder
    
    var body: some View {
        ZStack{
            Blur()
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    self.reminder = Reminder(name: "Listen to this!", time: Date(), isOn: true) //Not sur it's usefull
                    showModal.toggle()
                }
            
            VStack{
                VStack(alignment: .center) {
                    Text("Select the moment")
                        //                    .font(.caption)
                        .foregroundColor(.primary)
                    HStack {
                        Image(systemName: "calendar.circle.fill")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35, height: 35)
                        if #available(iOS 14.0, *) {
                            DatePicker(selection: $reminder.time, displayedComponents: .hourAndMinute){
                                Text("")
                            }
                        } else {// To hide show only few lines of the picker in iOS 13 or lower
                            DatePicker(selection: $reminder.time, displayedComponents: .hourAndMinute){
                                Text("")
                            }
                            .frame(width: 150, height: 120)
                            .mask(iOS13DatePickerMask())
                        }
                    }
                    HStack (alignment: .center){
                        Button(action: {
                            print("Modify Reminder View playback button tapped")
                            self.audioPlayer.startPlayback(audio: self.reminder.fileURL!)
                        }) {
                            Image(systemName: "play.circle")
                                .foregroundColor(reminder.fileURL == nil ? .gray : .pink)
                                .font(.system(size: 40))
                                .padding()
                        }.disabled(reminder.fileURL == nil)
            
                        Button(action: {
                            //erase the audio recorded
                            print("Modify Reminder View erase button tapped")
                            self.audioRecorder.deleteRecording(urlsToDelete: [self.reminder.fileURL!])
                            self.recordIsPresent = false
                            self.reminder.fileURL = nil
                        }) {
                            Image(systemName: "gobackward")
                                .foregroundColor(reminder.fileURL == nil ? .gray : .red)
                                .font(.system(size: 30))
                                .opacity(0.6)
                                .padding()
                        }.disabled(reminder.fileURL == nil)
                    }

                    Button(action: {
                        // Delete the oldOne
                        if self.reminder.notificationID != nil {
                            ReminderHandler().unable(reminder: reminder)
                            self.reminders.removeAll(where: { $0.id == reminder.id })
                        }
                        //Creating the notification and assigning the requestID to the notificationID value of the reminder
                        self.reminder.notificationID = ReminderHandler().create(reminder: self.reminder)
                        self.reminders.append(self.reminder)
                        let defaults = UserDefaults.standard
                        defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
                        //Reset the empty reminder of the ContentView
                        self.reminder = Reminder(name: "Listen to this!", time: Date(), isOn: true)
                        //Dismiss the modal
                        showModal.toggle()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(width: 170, height: 30)
                            .background(reminder.fileURL == nil ? Color.gray : Color.pink)
                            .cornerRadius(10)
                    }
                    .disabled(reminder.fileURL == nil)
                }
                .padding()
                .background(Color(UIColor.systemBackground).cornerRadius(20).shadow(radius: 10))
                .frame(width: 200, height: 150)
                .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
                
                Text("Please turn OFF the silent mode.\nWhen the time will come, you will need to hear this.")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.pink)
                    .offset(y: 50)
                
                ModifyAudioPressAndHold(reminder: $reminder, showPleaseHoldToRecordModal: $showPleaseHoldToRecordModal, recordIsPresent: $recordIsPresent)
                    .offset(y: 100)
                    .opacity(recordIsPresent ? 0 : 1)
                    .disabled(recordIsPresent)
            }
        }
    }
}

struct iOS13DatePickerMask : View {
    var body:  some View {
        HStack {
            Spacer()
            Rectangle()
                .frame(width: 130, height: 120)
                .cornerRadius(15)
//               .offset(y: 55)
            Spacer()
        }
    }
}

