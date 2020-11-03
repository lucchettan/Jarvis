//
//  ContentView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var audioRecorder = AudioRecorder()
    @ObservedObject var audioPlayer = AudioPlayer()
    
//    @State var isModal: Bool = false    + line52  .sheet()        it goes with the submit view modal
//    @State var recordingIsClicked = false
    @State var showPleaseHoldToRecordModal = false
    @State var showModal = false
//--Generate value that we will assign to validate the new reminder
    @State var date = Date()
//--Empty reminder to work with and restart like this when saving done in the modal(the name is displayed in the Notification)
    @State var newReminder = Reminder(name: "If I say so!", time: Date(), isOn: true)
//--Array in the wich we are going to add our created Memo
    @State var reminders: [Reminder] = []
    
    var body: some View {
        ZStack {
            NavigationView {
                    VStack {
                        if reminders.count == 0 {
                            VStack{
                                Text("No reminder for the moment.")
                                Text("Record yourself!🎬")
                            }
                        } else {
                            List {
                                ForEach(reminders, id: \.self) { reminder in
                                    ReminderCellView(reminder: reminder, reminders: self.reminders).frame(height: 40)
                                        .padding()

                                }
                                //----------------erase with the native deleting gesture
                                .onDelete(perform: self.deleteRow)
                            }
                            .padding()
                            .background(Color(UIColor.systemBackground))
                        }
                    }
                        .onAppear{
                            let defaults = UserDefaults.standard
                            guard let remindersData = defaults.object(forKey: "reminders") as? Data else { return }
                            guard let DecodedReminders = try? PropertyListDecoder().decode([Reminder].self, from: remindersData) else { return }
                            self.reminders = DecodedReminders
                        }
                    .navigationBarTitle(Text("Recordings"), displayMode: .inline)
            }
//                .sheet(isPresented: $isModal, content: {Submit(isModal: self.$isModal, reminders: self.$reminders)})
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

            VStack {
                Spacer()
                HStack(alignment: .center){
                    Spacer()
                    if showPleaseHoldToRecordModal {
                        Text("Please hold to record 🎙")
                            .foregroundColor(.pink)
                            .animation(.easeInOut)
                    }
                    ZStack {
                        PressAndHoldButton(reminder: $newReminder, showModal: $showModal, showPleaseHoldToRecordModal: $showPleaseHoldToRecordModal)
                    }
                }
                .frame(maxHeight: 100)
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
            
            Blur()
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(showModal ? 1 : 0)
                .animation(.easeIn)

            DateSelectionModal(showModal: $showModal, reminders: $reminders, newReminder: $newReminder)
                .offset(x: 0, y: showModal ? 0 : 800)
                .animation(.easeIn)
        }
    }
    
//--Delete Reminder, we have to add deleting the sourcefile of Reminder.soundUrl
    private func deleteRow(at indexSet: IndexSet) {
        
        for index in indexSet {
            self.audioRecorder.deleteRecording(urlsToDelete: [self.reminders[Int(index)].fileURL!])
            ReminderHandler().unable(reminder: self.reminders[Int(index)])
        }
        self.reminders.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
