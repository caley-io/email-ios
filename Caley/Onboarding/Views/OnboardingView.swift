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
    
    @State private var authState = "welcome"
    @State private var showAuthenticationModal = false
    
    var body: some View {
        ZStack {
            VStack{
                AlirezaEmailView()
                JeremyEmailView()
                
                VStack {
                    ForEach(emails, id: \.id) { email in
                        HStack(alignment: .top) {
                            VStack {
                                Image(email.image)
                                    .resizable()
                                    .frame(width: 23, height: 23)
                                    .clipShape(Circle())
                                
                                Spacer()
                            }
                            
                            VStack(spacing: 4) {
                                HStack {
                                    
                                    
                                    Text(email.author)
                                        .font(.system(size: 14, weight: .medium))
                                    
                                    Spacer()
                                    
                                    Text("2:29pm")
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(.gray)
                                }
                                
                                HStack {
                                    Text(email.subject)
                                        .font(.system(size: 13, weight: .medium))
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text(email.body)
                                        .font(.system(size: 13, weight: .medium))
                                        .foregroundStyle(.gray)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                    
                                    Spacer()
                                    HStack {
                                        Image(systemName: "book.pages")
                                            .font(.system(size: 13))
                                        Text("2 min")
                                            .font(.system(size: 13))
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 0)
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
                        self.showAuthenticationModal = true
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
                        self.showAuthenticationModal = true
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
        .sheet(isPresented: $showAuthenticationModal) {
            VStack(alignment: .leading) {
                if auth.isAuthState == .signinUp  {
                    RegisterView()
                } else {
                    LoginView(error: nil) {
                        signin in
                        
                        print("got signin \(signin)")
                    }
                }
            }
            .padding(.all, 10)
            .padding(.top, 20)
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea([.all])
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
