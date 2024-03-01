//
//  OnboardingView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var auth: MockAuthModel
    @State var emails: [Mail] = []
    
    var body: some View {
        ZStack {
            VStack{
                AlirezaEmailView()
                JeremyEmailView()
                
                VStack {
                    ForEach(emails, id: \.id) { email in
                        EmailListItemView(email: email)
                    }
                }.onAppear(perform: {
                    loadEmails()
                })
                .padding(.top)
                .padding([.leading, .trailing], 14)
                
            }.mask(
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black, Color.black.opacity(0), Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
            )
            
            VStack {
                Spacer()
                
                Image("logo")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                
                Text("Welcome to Caley")
                    .font(.title)
                    .fontWeight(.bold)
                    
                
                VStack {
                    Button(action: {
                        auth.signUp()
                    }) {
                            Text("Sign up")
                            .padding()
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity)
                          }
                    .buttonStyle(.plain)
                        .foregroundColor(.black)
                        .background(Color("lightBg"))
                        .cornerRadius(100)
                    
                    Button(action: {
                        auth.signIn()
                    }) {
                            Text("Login")
                              .padding()
                              .fontWeight(.bold)
                              .frame(maxWidth: .infinity)
                    }.buttonStyle(.plain)
                        .foregroundColor(.white)
                        .background(.thinMaterial)
                        .cornerRadius(100)
                }.padding(.all)
            }
            
        }
    }
    
    func loadEmails() {
        if let path = Bundle.main.path(forResource: "emails", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                self.emails = try decoder.decode([Mail].self, from: data)
            } catch {
                print("Error reading JSON: \(error)")
                emails = []
            }
        } else {
            print("JSON not found")
            emails = []
        }
    }
}

#Preview {
    OnboardingView().preferredColorScheme(.dark)
}
