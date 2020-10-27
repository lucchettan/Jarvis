//
//  ReminderView.swift
//  Jarvis0.0
//
//  Created by Florent on 21/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct ReminderView: View {
    //MARK:- PROPERTIES
    
    @State private var date = Date()
    @State private var turningChevron = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(.white)
                    .frame(width: 250, height: turningChevron ? 150 : 100)
                    .shadow(radius: 20)
    
            HStack {
                    Image(systemName: "calendar.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 10)
                    
                    Text("Choose the right moment")
                        .font(.footnote)
                
                    Spacer()
                    
                    Button(action: {
                        turningChevron.toggle()
                    }) {
                        Image(systemName: turningChevron ? "chevron.down" : "chevron.right")
                            .foregroundColor(.black)
                            .offset(x: turningChevron ? 75 :  0, y:  turningChevron ? 0 : 0)
                        
                        if turningChevron {
                             
                            DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                                    .position(x: -47, y: 420)
                                
                         }
                    }
                }
                .offset(x: turningChevron ? 0 : 0, y: turningChevron ? -30 : 0)
                .padding(.horizontal, 60)
        }
        .padding(.horizontal)
    }
}


struct ReminderView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderView()
    }
}
