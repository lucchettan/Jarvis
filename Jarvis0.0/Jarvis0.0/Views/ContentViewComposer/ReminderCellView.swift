//
//  ReminderCellView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.


import SwiftUI

struct ReminderCellView: View {
    @ObservedObject var audioPlayer = AudioPlayer()
    @State var reminder: Reminder
    
    var body: some View {
        HStack {
            Text(getHourFromDate(date: self.reminder.time))
                .font(.system(size: 40))
                .frame(width: 110)
            Button(action: {
                self.audioPlayer.startPlayback(audio: self.reminder.fileURL!)
            }) {
                Image(systemName: "play.circle")
                    .foregroundColor(.orange)
                    .font(.system(size: 40))
                    .padding()
            }
            Spacer()
            CustomToggle(reminder: $reminder)
            
        }
        .padding(EdgeInsets(top: 0, leading: -20, bottom: 0, trailing: -30))
    }

    func getHourFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.dateFormat  = "HH:mm"
        return formatter.string(from: date)
    }
}
