//
//  PressAndHoldButton.swift
//  Jarvis0.0
//
//  Created by mac on 27/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct PressAndHoldButton: View {
    @State var tapStatus = ""
    @State var isClicked = false
    @State var longPressDetected = false
    
    var body: some View {
        Button(action: {
            if self.longPressDetected {
                // 2-  Exectued after a long press detected.
                isClicked = false
                longPressDetected = false
            } else {
                // Exectued after a simple Tap detected.
            }

        }) {
            ZStack{
                //The animation will be displayed only while isClicked is true
                if isClicked { RoundAnimation() }
                
                Image(systemName: "mic.circle.fill")
                    .resizable()
                    .frame(width: 55, height: 55)
                    .foregroundColor(.pink)
            }
        }
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.1).onEnded({ _ in
                //1- Those action will be triggered when the hold is detected.
                isClicked = true
                longPressDetected = true
            })
        )
    }
}

struct PressAndHoldButton_Previews: PreviewProvider {
    static var previews: some View {
        PressAndHoldButton()
    }
}
