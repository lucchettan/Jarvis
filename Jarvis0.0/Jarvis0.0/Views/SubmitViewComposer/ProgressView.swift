//
//  ProgressView.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 30/01/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct ProgressView: View {
    @Binding var value : CGFloat
    @Binding var time : Int
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(Color(.gray),style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-215))
                .frame(width: 170, height: 170)
                .opacity(0.2)
            
            Circle()
                .trim(from: 0, to: value)
                .stroke(Color.orange,style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .rotationEffect(.degrees(-215))
                .frame(width: 170, height: 170)
                .animation(.linear(duration: 1.0))
        }
    }
}
