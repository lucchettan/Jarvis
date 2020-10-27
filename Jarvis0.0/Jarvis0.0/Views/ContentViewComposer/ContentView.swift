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
    @State var isModal: Bool = false
    @State var reminders: [Reminder] = []

    
    var body: some View {
       
        NavigationView {
            VStack {
                List {
                    ForEach(reminders, id: \.self) { reminder in
                        ReminderCellView(reminder: reminder, reminders: self.reminders).frame(height: 40)
                            .padding()
                    }
//----------------erase with the native deleting gesture
                    .onDelete(perform: self.deleteRow)
                }
                    .padding()
                    .onAppear{
                        let defaults = UserDefaults.standard
                        guard let remindersData = defaults.object(forKey: "reminders") as? Data else { return }
                        guard let DecodedReminders = try? PropertyListDecoder().decode([Reminder].self, from: remindersData) as! [Reminder] else { return }
                        self.reminders = DecodedReminders
                    }
            }
                .navigationBarTitle("Recordings")
                .navigationBarItems(trailing: Button("+"){
                    self.isModal.toggle()
                    print("")
                }
                .font(.system(size: 40))
                .foregroundColor(.orange))
        }
            .sheet(isPresented: $isModal, content: {Submit(isModal: self.$isModal, reminders: self.$reminders)})
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
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
