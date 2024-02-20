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
            if let error {
                Text(error).foregroundStyle(.red)
                Divider()
            }
            TextField("User Name", text: $username)
            TextField("Password", text: $password)


            HStack {
                Button("Sign In") {
                    auth.login(method: .standard(name: username, password: password))
                }
                
                Button("Sign Up") {
                    auth.signUp()
                }
            }
        }
        .padding()
    }
}
