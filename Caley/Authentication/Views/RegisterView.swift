//
//  RegisterView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var auth: MockAuthModel
    
    @State var value: Int = 1
    @State var numberOfStep: Int = 6
    @State var step: Int = 0
    
    @State var username: String = ""
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var password: String = ""
    @State var confirmationCode: String = ""
    
    let elements: [Any] = [MailView.self, FirstName.self, LastName.self, Password.self, ConfirmationCode.self, Success.self]
    
    func buildView(types: [Any], index: Int) -> AnyView {
        
        switch types[index].self {
        case is MailView.Type: return AnyView( MailView(username: $username) )
        case is FirstName.Type: return AnyView( FirstName(firstName: $firstName) )
        case is LastName.Type: return AnyView( LastName(lastName: $lastName) )
        case is Password.Type: return AnyView( Password(password: $password) )
        case is ConfirmationCode.Type: return AnyView( ConfirmationCode(confirmationCode: $confirmationCode) )
        case is Success.Type: return AnyView( Success() )
        default: return AnyView(EmptyView())
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Button(action: {
                    self.step -= 1
                    self.value -= 1
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(self.step == 0 || self.step == 5 ? .clear : .white)
                        .font(.system(size: 20, weight: .black))
                }
            }
            
            VStack(alignment: .leading) {
                buildView(types: elements, index: step)
            }
            Spacer()
            
            if self.step != self.numberOfStep - 1 {
                VStack {
                    ProgressBar(value: $value, numberOfStep: $numberOfStep)
                    
                    RoundedButton(action: {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                        if self.step == 3 {
                            self.step += 1
                            self.value += 1
                        } else if self.step < self.numberOfStep - 2 {
                            self.step += 1
                            self.value += 1
                        } else {
                            
                            auth.state = .signedIn
                        }
                    }, text: self.step == 3 ?
                        "Sign up" :
                        self.step < self.numberOfStep - 2 ?
                            "Next" :
                        "Confirm" , variant: "dark").padding(.top, 10)
                }
            }
        }.padding(.bottom, 40)
    }
}
