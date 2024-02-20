//
//  CaleyApp.swift
//  Caley
//
//  Created by Jeremy Scatigna on 13/02/2024.
//

import SwiftUI
import SwiftData

@main
struct CaleyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MockAuthModel())
                .modelContainer(for: [Action.self, Email.self])
        }
    }
}
