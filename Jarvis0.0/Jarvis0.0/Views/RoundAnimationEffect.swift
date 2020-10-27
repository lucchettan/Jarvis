//
//  RoundAnimation.swift
//  Jarvis0.0
//
//  Created by mac on 21/10/2020.
//  Copyright © 2020 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct RoundAnimation: View {
    @State var animationAmount : CGFloat = 1
    var waveAnimationColor = Color.pink
    var body: some View {
        Circle()
            .frame(width: 55, height: 55)
            .foregroundColor(waveAnimationColor)
            .overlay(
                ZStack {
                    Circle()
                        .foregroundColor(waveAnimationColor.opacity(0.8))
                        .scaleEffect(animationAmount + 0.8)
                        .opacity(Double(-1 + animationAmount))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    Circle()
                        .foregroundColor(waveAnimationColor.opacity(0.5))
                        .scaleEffect(animationAmount + 0.2)
                        .opacity(Double(-1 + animationAmount))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                    Circle()
                        .foregroundColor(waveAnimationColor.opacity(0.2))
                        .scaleEffect(animationAmount - 0.4)
                        .opacity(Double(-1 + animationAmount))
                        .animation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true))
                }
            )
            .onAppear(){ self.animationAmount = 2 }

    }
}

struct RoundAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RoundAnimation()
    }
}
