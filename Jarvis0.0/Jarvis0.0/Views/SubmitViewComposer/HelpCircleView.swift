//
//  HelpCircleView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 30/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct HelpCircleView: View {
    @State var animationAmount : CGFloat = 1

    var body: some View {
        ZStack{
            Circle()
                .foregroundColor(Color.orange)
                .opacity(0.1)
                .frame(width: 650, height: 650)
                .offset(y: 400)
                .animation(.spring())
            Text("You have 30 seconds")
                .bold()
                .offset(y: 105)
                .foregroundColor(.gray)
                .animation(.spring())
        }
    }
}
