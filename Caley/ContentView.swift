//
//  ContentView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 13/02/2024.
//

import SwiftUI
import CoreMotion
import SwiftData

struct ContentView: View {
    @EnvironmentObject private var auth: MockAuthModel
    @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
    @Environment(\.modelContext) private var modelContext
    
    @Query private var actions: [Action]
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        switch auth.state {
            
        case .signedIn:
            MailboxView()
            
        case .notSignedIn(let error):
            OnboardingView()
        }
    }
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
}
