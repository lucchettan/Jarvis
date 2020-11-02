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

    @State var showModal = false
    var haptics = UINotificationFeedbackGenerator()
    
    //MARK:- BODY
    var body: some View {
        
        ZStack {
            NavigationView {
                ZStack {
                    VStack {
                        Text("Aucun Enregistrement")
                            .font(.system(size: 22, weight: .thin))
//                        modalDateSelection(showModal: $showModal)
//                            .offset(x: 0, y: showModal ? 0 : 600)
                    VStack {
                        Button(action: {
                            showModal.toggle()
                        }) {
                            Circle()
                                .foregroundColor(.pink)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .strokeBorder(Color.white, lineWidth: 1)
                                        Image(systemName: "mic.fill")
                                            .foregroundColor(.white)
                                    }
                                )
                                .shadow(radius: 8)
                            }
                        } //:Vstack
                         .offset(x: 140, y: 240)
                         .navigationBarTitle(Text("Recordings"), displayMode: .inline)
                    }
                }
            }
        }
    }
}
    


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.light)
    }
}
