//
//  Input.swift
//  shyc
//
//  Created by Jeremy Scatigna on 09/04/2020.
//  Copyright © 2020 Jeremy Scatigna. All rights reserved.
//

import SwiftUI

struct Input: View {
    @Binding var text: String
    var placeholder: String
    var label: String
    var isSecure: Bool
    var isSignup: Bool?
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        VStack(alignment: .leading) {
                Text(label)
                .foregroundColor(.white)
                .font(isSignup == true ? .system(size: 26, weight: .heavy, design: .default) : .system(size: 18, weight: .medium))
                .padding(.bottom, -12)
            
            if isSecure {
                SecureField(placeholder, text: $text, onCommit: commit)
                    .foregroundColor(Color(UIColor.lightGray))
                    .accentColor(Color(UIColor.lightGray))
                    .font(isSignup == true ? .system(size: 20, weight: .medium) : .system(size: 26, weight: .heavy, design: .default))
            } else {
                TextField(placeholder, text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    .foregroundColor(Color(UIColor.lightGray))
                    .accentColor(Color(UIColor.lightGray))
                    .font(isSignup == true ? .system(size: 20, weight: .medium) : .system(size: 26, weight: .heavy, design: .default))
            }
            
        }.padding()
    }
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello world")
        }
        
    }
}
