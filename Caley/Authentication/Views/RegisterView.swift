//
//  RegisterView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var auth: MockAuthModel
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var error: String?

    var body: some View {
        VStack {
            if let error {
                Text(error).foregroundStyle(.red)
                Divider()
            }
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            TextField("Password", text: $password)


            HStack {
                Button("Sign In") {
                    auth.signIn()
                }
                
                Button("Sign Up") {
                    auth.register(method: .standard(name: name, email: email, password: password))
                }
            }
        }
        .padding()
    }
}
