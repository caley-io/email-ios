//
//  LoginView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var auth: MockAuthModel

    @State private var username = ""
    @State private var password = ""
    
    var error: String?
    var signup: (AuthSignIn) -> Void
    
    var body: some View {
        VStack {
            
                Input(text: $username, placeholder: "Enter your email", label: "Email", isSecure: false)
                Input(text: $password, placeholder: "Enter your password", label: "Password", isSecure: true)
                
                Spacer()
                
                RoundedButton(action: {
                    auth.state = .signedIn
            }, text: "Login", variant: "dark").padding(.top, 10)
            
        }.padding(.bottom, 40)
    }
}
