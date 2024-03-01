//
//  Button.swift
//  shyc
//
//  Created by Jeremy Scatigna on 09/04/2020.
//  Copyright © 2020 Jeremy Scatigna. All rights reserved.
//

import SwiftUI

struct RoundedButton: View {
    var action: () -> Void
    var text: String
    var variant: String
    
    var body: some View {
        VStack {
            if variant == "white" {
                Button(action: action) {
                    Text(text)
                    .foregroundColor(Color("lightBg"))
                    .fontWeight(.heavy)
                    .frame(minWidth: 100, maxWidth: .infinity)
                }
                .frame(minWidth: 100, maxWidth: .infinity)
                .padding()
                .background(Capsule().fill(.thinMaterial)
                )
            } else {
                Button(action: action) {
                    Text(text)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                        .frame(minWidth: 100, maxWidth: .infinity)
                }
                .frame(minWidth: 100, maxWidth: .infinity)
                .padding()
                .background(Capsule().fill(Color("lightBg"))
                )
            }
        }
    }
}

struct Button_Previews: PreviewProvider {
    static var previews: some View {
        RoundedButton(action: {
            
        }, text: "LOGIN", variant: "white")
    }
}
