//
//  ContentView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var isModal: Bool = false
    @State var reminders: [Reminder] = []
    
    var body: some View {
       
        NavigationView {
            VStack {
                List {
                    ForEach(reminders, id: \.self) { reminder in
                        ReminderCellView(reminder: reminder).frame(height: 50)
                            .padding()
                    }
                    //erase with the native deleting gesture
                    .onDelete(perform: self.deleteRow)
                }.padding()
                Button(action: {self.isModal = true}){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                       
                }
//                Button(action: {Reader().stringReader(string: "Wesh Ma Gueule")}){
//                                 Image(systemName: "play.circle.fill")
//                                     .resizable()
//                                     .frame(width: 50, height: 50)
//                                     .foregroundColor(.orange)
//                }
                
                    .onAppear{
                        guard let myreminders = UserDefaults.standard.array(forKey: "reminders") else {return}
                        self.reminders = myreminders as! [Reminder]
                }
            }
        .navigationBarTitle("Remind me!")
        }
        .sheet(isPresented: $isModal, content: {SubmitView(isModal: self.$isModal, reminders: self.$reminders)})
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    private func deleteRow(at indexSet: IndexSet) {
        self.reminders.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
