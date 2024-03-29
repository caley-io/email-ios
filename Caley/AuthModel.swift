//
//  AuthModel.swift
//  AuthFlow
//
//  Created by Mark Onyschuk on 02/16/24.
//

import Foundation

// codable so we can store it
enum AuthState: Codable {
    case signedIn
    case notSignedIn(error: String?)
}

enum IsAuthencating: Codable {
    case logingIn
    case signinUp
}

struct AuthSignUpState: Codable {
    var name: String = ""
    var email: String = ""
    var password: String = ""
}

enum AuthSignIn {
    case standard(name: String, password: String)
}

enum AuthRegister {
    case standard(name: String, email: String, password: String)
}

protocol AuthModel: AnyObject & ObservableObject {
    var state: AuthState { get }
    
    func login(method: AuthSignIn)
    
    func signUp()
    
    func register(method: AuthRegister)
    
    func logout()
}

final class MockAuthModel: AuthModel {
    @Published var state = AuthState.notSignedIn(error: nil)
    @Published var isAuthState = IsAuthencating.logingIn
    
    func login(method: AuthSignIn) {
        switch method {
        case let .standard(name: name, password: password):
            if name == "foo" && password == "bar" {
                state = .signedIn
            } else {
                state = .notSignedIn(error: "Bad password")
            }
        }
    }
    
    func register(method: AuthRegister) {
        switch method {
        case let .standard(name: name, email: email, password: password):
            state = .signedIn
        }
    }
    
    func signUp() {
        isAuthState = .signinUp
    }
    
    func signIn() {
        isAuthState = .logingIn
        state = .notSignedIn(error: nil)
    }
    
    func logout() {
        state = .notSignedIn(error: nil)
    }
}
