//
//  ContentView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 13/02/2024.
//

import SwiftUI
import CoreMotion
import SwiftData

struct Person {
    let imageName: String
    let name: String
    let username: String
    let post: String
    let id: Int
    let time: String
}

struct MenuItem {
    let id: Int
    let name: String
    let selected: Bool
    let icon: String
    let count: String
}


enum DeviceOrientation {
    case unknown, portrait, upsideDown
}

let menu = [
    MenuItem(id: 1, name: "Inbox", selected: true, icon: "tray.fill", count: "28"),
    MenuItem(id: 2, name: "Done", selected: false, icon: "checkmark.circle", count: "4"),
    MenuItem(id: 3, name: "Team", selected: false, icon: "building", count: "2"),
    MenuItem(id: 4, name: "Calendar", selected: false, icon: "calendar", count: "18"),
    MenuItem(id: 5, name: "VIP", selected: false, icon: "star", count: "0"),
    MenuItem(id: 6, name: "Sent", selected: false, icon: "paperplane", count: "4"),
    MenuItem(id: 7, name: "Send later", selected: false, icon: "clock.arrow.circlepath", count: "13"),
    MenuItem(id: 8, name: "Draft", selected: false, icon: "book.pages", count: "76"),
    MenuItem(id: 9, name: "Archive", selected: false, icon: "archivebox", count: "19"),
    MenuItem(id: 10, name: "Trash", selected: false, icon: "trash", count: "123"),
]

let people1 = [
    Person(imageName: "gavin", name: "jeremy", username: "geekpreneur", post: "i don’t care about the future of computing i just want to make people feel things", id: 1, time: "11m"),
    Person(imageName: "gavin", name: "kelin", username: "kelin", post: "i don’t care about the future of computing i just want to make people feel things", id: 2, time: "11m"),
    Person(imageName: "gavin", name: "gavin", username: "gavinnelson", post: "maybe it’s because I use GitHub all day, but my #1 request for all “improve writing” style GPT requests is to be able to easily see a diff comparing the input and output", id: 3, time: "21m"),
    Person(imageName: "gavin", name: "Joey Banks", username: "joeyabanks", post: "'Dream in years. Plan in months. Evaluate in weeks. Ship daily.' -DJ Patil", id: 4, time: "36m"),
    Person(imageName: "gavin", name: "shu", username: "shu", post: "With Next.js’ app directory and that new idea, it takes less than 150 lines of code to create this. ~4 lines are actually related to animation (wrapping the tree with <Satori>)", id: 5, time: "48m"),
    Person(imageName: "gavin", name: "jeremy", username: "geekpreneur", post: "i don’t care about the future of computing i just want to make people feel things", id: 1, time: "11m"),
    Person(imageName: "gavin", name: "kelin", username: "kelin", post: "i don’t care about the future of computing i just want to make people feel things", id: 2, time: "11m"),
    Person(imageName: "gavin", name: "gavin", username: "gavinnelson", post: "maybe it’s because I use GitHub all day, but my #1 request for all “improve writing” style GPT requests is to be able to easily see a diff comparing the input and output", id: 3, time: "21m"),
    Person(imageName: "gavin", name: "Joey Banks", username: "joeyabanks", post: "'Dream in years. Plan in months. Evaluate in weeks. Ship daily.' -DJ Patil", id: 4, time: "36m"),
    Person(imageName: "gavin", name: "shu", username: "shu", post: "With Next.js’ app directory and that new idea, it takes less than 150 lines of code to create this. ~4 lines are actually related to animation (wrapping the tree with <Satori>)", id: 5, time: "48m"),
    Person(imageName: "gavin", name: "jeremy", username: "geekpreneur", post: "i don’t care about the future of computing i just want to make people feel things", id: 1, time: "11m"),
    Person(imageName: "gavin", name: "kelin", username: "kelin", post: "i don’t care about the future of computing i just want to make people feel things", id: 2, time: "11m"),
    Person(imageName: "gavin", name: "gavin", username: "gavinnelson", post: "maybe it’s because I use GitHub all day, but my #1 request for all “improve writing” style GPT requests is to be able to easily see a diff comparing the input and output", id: 3, time: "21m"),
    Person(imageName: "gavin", name: "Joey Banks", username: "joeyabanks", post: "'Dream in years. Plan in months. Evaluate in weeks. Ship daily.' -DJ Patil", id: 4, time: "36m"),
    Person(imageName: "gavin", name: "shu", username: "shu", post: "With Next.js’ app directory and that new idea, it takes less than 150 lines of code to create this. ~4 lines are actually related to animation (wrapping the tree with <Satori>)", id: 5, time: "48m"),
]

let people2 = [
    Person(imageName: "gavin", name: "Josh Miller", username: "joshm", post: "Lil' personal life update: 🇫🇷 I'm moving to Paris – for one year – starting in September! 🇫🇷", id: 6, time: "1s"),
    Person(imageName: "gavin", name: "Alex Widua", username: "alexwidua", post: "I started with the idea of using a physical flip interaction to start/reset a timer and iterated from that", id: 7, time: "2m"),
    Person(imageName: "gavin", name: "Janum Trivedi", username: "jmtrivedi", post: "- The values for each dot (translation, scale, spring response, etc.), are all keyed off of the touch’s distance - UIKit/Wave here, but made another in Metal for more “correct” deformation", id: 8, time: "6  m"),
    Person(imageName: "gavin", name: "Lous Harboe", username: "spiralstairs", post: "here's a little one-handed search concept. field pinned to bottom + drag to dismiss. no more reaching 🙌🏼", id: 9, time: "4m"),
    Person(imageName: "gavin", name: "John Allen", username: "Jall_n", post: "The modern compass: designed for exploration, built for collaboration, AI as the foundation", id: 10, time: "8m"),
]

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
            LoginView(error: error) {
                signin in
                
                print("got signin \(signin)")
            }
            
        case .signingUp(_):
            RegisterView()
        }
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

#Preview {
    ContentView()
        .modelContainer(for: [Action.self])
}
