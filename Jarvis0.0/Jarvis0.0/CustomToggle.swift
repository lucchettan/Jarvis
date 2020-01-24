//
//  CustomToggle.swift
//  Jarvis0.0
//
//  Created by Nicolas Lucchetta on 18/12/2019.
//  Copyright © 2019 Nicolas Lucchetta. All rights reserved.
//

import SwiftUI

struct CustomToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            if !isOn {
                Spacer()
            }
            Circle()
                .fill(Color.white)
                .frame(width: 20, height: 20)
                .animation(.spring())
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < 0 {
                                self.isOn = true
                            } else {
                                self.isOn = false
                            }
                        }
                )

            if isOn {
                Spacer()
            }
        }
        .frame(width: 40, height: 20)
        .padding(5.0)
        .background(isOn ? Color.green : Color.red)
        .animation(.easeInOut)
        .cornerRadius(50)
        .onTapGesture {
            self.isOn.toggle()
            print(self.isOn)
        }
    }
}
