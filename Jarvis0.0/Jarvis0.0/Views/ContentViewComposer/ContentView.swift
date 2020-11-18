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
    
//--Generate value that we will assign to validate the new reminder
    @State var date = Date()
//--Empty reminder to work with and restart like this when saving done in the modal(the name is displayed in the Notification)
    @State var newReminder = Reminder(name: "Listen to this!", time: Date(), isOn: true)
//--Array in the wich we are going to add our created Memo
    @State var reminders: [Reminder] = []
    
    @State var showPleaseHoldToRecordModal = false
    @State var showCreationModal = false
    @State var reminderToEdit = Reminder(name: "Listen to this!", time: Date(), isOn: true)
    @State var showModifyView = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Recordings")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding()
                VStack {
                    if reminders.count == 0 {
                        VStack{
                            Spacer()
                            Text("No reminder for the moment.")
                            Text("Record yourself!🎬")
                            Spacer()
                        }
                    } else {
                        List {
                            ForEach(reminders.sorted(by: { $0.time < $1.time }), id: \.self) { reminder in
                                ReminderCellView(reminder: reminder, reminders: self.$reminders, reminderToEdit: self.$reminderToEdit, showModifyView: self.$showModifyView)
                                    .frame(height: 40)
                                    .padding()
                                    .animation(.easeOut)
                            }
                        }
//                      .padding()
                        .background(Color(UIColor.systemBackground))
                        .edgesIgnoringSafeArea(.all)
                    }
                }
                .onAppear {
                    let defaults = UserDefaults.standard
                    guard let remindersData = defaults.object(forKey: "reminders") as? Data else { return }
                    guard let DecodedReminders = try? PropertyListDecoder().decode([Reminder].self, from: remindersData) else { return }
                    self.reminders = DecodedReminders
                }
            }

            VStack {
                Spacer()
                HStack(alignment: .center){
                    Spacer()
                    if showPleaseHoldToRecordModal {
                        Text("Please hold to record 🎙")
                            .foregroundColor(.pink)
                            .animation(.easeInOut)
                    }
                    PressAndHoldButton(reminder: $newReminder, showModal: $showCreationModal, showPleaseHoldToRecordModal: $showPleaseHoldToRecordModal)
                }
                .frame(maxHeight: 100)
                .padding(.horizontal)
            }
            .frame(maxHeight: .infinity)
            
            Blur()
                .edgesIgnoringSafeArea(.vertical)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .opacity(showCreationModal  ? 1 : 0)
                .animation(.easeIn)
            //Creation Modal
            DateSelectionModal(showModal: $showCreationModal, reminders: $reminders, reminder: $newReminder)
                .offset(x: 0, y: showCreationModal ? 0 : 800)
                .animation(.easeIn)
            
            //Modification Modal
            if showModifyView {  // le If est necessaire pour generer la moadle avec le reminder une fois le reminder selectionne
                ZStack{             // mais ca casse l'animation
                    DateSelectionModal(showModal: $showModifyView, reminders: $reminders, reminder: $reminderToEdit)
                        .frame(width: showModifyView ? UIScreen.main.bounds.width : 0, height: showModifyView ? UIScreen.main.bounds.height : 0)
//                        .offset(x: 0, y: showModifyView ? 0 : 800)


                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .animation(.easeInOut)
            }
        }
    }
    
    // Delete Reminder
    private func deleteRow(at indexSet: IndexSet) {
        for index in indexSet {
            // Delete the sourcefile of Reminder.fileUrl
            self.audioRecorder.deleteRecording(urlsToDelete: [self.reminders[Int(index)].fileURL!])
            // Unable the notification from the notification Center
            ReminderHandler().unable(reminder: self.reminders[Int(index)])
        }
        self.reminders.remove(atOffsets: indexSet)
        let defaults = UserDefaults.standard
        defaults.set(try? PropertyListEncoder().encode(self.reminders), forKey: "reminders")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
