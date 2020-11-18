    //
//  ReminderCellView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.


import SwiftUI

struct ReminderCellView: View {
    @ObservedObject var audioPlayer = AudioPlayer()
    @ObservedObject var audioRecorder = AudioRecorder()
    @State var reminder: Reminder
    @Binding var reminders : [Reminder]
    
    @Binding var reminderToEdit : Reminder
    @Binding var showModifyView : Bool
//
    let width : CGFloat = UIScreen.main.bounds.width
    @State var offset = CGSize.zero
    @State var scale : CGFloat = 0.5
//
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack (alignment: .center){
                    HStack (spacing: 0){
                        Text(getHourFromDate(date: self.reminder.time))
                            .font(.system(size: 40))
                            .frame(width : geo.size.width/2.7, alignment: .leading)
                        
                        Image(systemName: "play.circle")
                            .foregroundColor(.pink)
                            .font(.system(size: 40))
                            .padding()
                            .onTapGesture { self.audioPlayer.startPlayback(audio: self.reminder.fileURL!) }
                            .frame(width : geo.size.width/3)
                        
                        Spacer()
                        
                        CustomToggle(reminder: $reminder,reminders: self.reminders)
                            .frame(width : geo.size.width/2.5)
                    }
                    
                    HStack (spacing : 0){
                        Image(systemName: "pencil")
                            .font(.system(size: 25))
                            .scaleEffect(scale)
                            .frame(width: 55, height: geo.size.height, alignment: .leading)
                            .foregroundColor(Color.gray.opacity(0.85))
                            .onTapGesture {
                                self.reminderToEdit = self.reminder
                                self.showModifyView = true
                            }
                        
                        Image(systemName: "trash")
                            .font(.system(size: 30))
                            .scaleEffect(scale)
                            .frame(width: 55, height: geo.size.height, alignment: .leading)
                            .foregroundColor(Color.red)
                            .onTapGesture {
                                self.audioRecorder.deleteRecording(urlsToDelete: [self.reminder.fileURL!])
                                ReminderHandler().unable(reminder: self.reminder)
                                self.reminders.removeAll(where: { $0.time == reminder.time })
                                let defaults = UserDefaults.standard
                                defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
                            }
            
                    }
                    .frame(width : geo.size.width/3)
                    .offset(x: -15)
                }
                .frame(height: geo.size.height)
                .offset(self.offset)
                .animation(.spring())
                .gesture(DragGesture()
                            .onChanged { gesture in
//                                if self.offset.width > 0 && gesture.translation.width < 0 {
                                    self.offset.width = gesture.translation.width
//                                }
                            }
                            .onEnded { _ in
                                if self.offset.width < -50 {
                                    self.scale = 1
                                    self.offset.width = -(width * 0.25)
                                } else {
                                    self.scale = 0.5
                                    self.offset = .zero
                                }
                            }
                )
            }
        }
    }

    func getHourFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat  = "HH:mm"
        return formatter.string(from: date)
    }
}
