//
//  HomeView.swift
//  Jarvis0.0
//
//  Created by Florent on 21/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    //MARK:- Properties

    @State var showReminder = false
    @State var showDateReminder = false
    var haptics = UINotificationFeedbackGenerator()
    
    @ObservedObject var audioRec: AudioRecorder
    
    //MARK:- BODY
    var body: some View {
        
        ZStack {
            NavigationView {
                ZStack {
                    DateSelectionView(showReminder: $showReminder)
                    VStack {
                        Text("Aucun enregistrement vocal")
                            .font(.system(size: 22, weight: .thin))
                        
                    VStack {
                        Button(action: {
                            showReminder.toggle()
                            haptics.notificationOccurred(.success)
                        })
                        {
                        Circle()
                            .foregroundColor(.pink)
                            .frame(width: 60, height: 60)
                            .overlay(
                    ZStack{
                        Circle()
                            .strokeBorder(Color.white, lineWidth: 1)
                        Image(systemName: "mic.fill")
                            .foregroundColor(.white)
                            })
                             .shadow(radius: 8)
                            }
                        .blur(radius: showReminder ? 1 : 0)
                        } //:Vstack
                         .offset(x: 140, y: 300)
                         .navigationBarTitle(Text("Recordings"), displayMode: .inline)
                    
                    }
                    .blur(radius: showReminder ? 1 : 0)
                }
            }
         }

      }
   }
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(audioRec: AudioRecorder())
            .preferredColorScheme(.light)
    }
}

struct DateSelectionView: View {
    
    @Binding var showReminder: Bool
    @State var date = Date()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .foregroundColor(.white)
            .frame(width: 200, height: 150)
            .shadow(radius: 10)
            .overlay(
                VStack(alignment: .center) {
                    Text("Select the moment")
                        .font(.caption)
                        .foregroundColor(.primary)
                        .padding(.bottom,10)
                    HStack {
                        Image(systemName: "calendar.circle.fill")
                        .renderingMode(.original)
                        .resizable()
                        .scaledToFit()
                            .frame(width: 35, height: 35)
                        DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                    }
                    Spacer()
                    Button(action: {
                        showReminder.toggle()
                    }) {
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .frame(width: 170, height: 30)
                            .overlay(
                                Text("Save")
                                    .foregroundColor(.white))
                    }
                    .foregroundColor(.pink)
                    
                   }.padding()
            )
        
            .offset(x: 0, y: showReminder ? 60 : 500)
            .animation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5))
    }
}
