//
//  ContentView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 13/02/2024.
//

import SwiftUI
import CoreMotion

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
    
    @State private var topViewHeight: CGFloat = 480
    
    @State private var menuItems = menu
    @State public var selectedMenu = 1
    
    @State private var dragState = DragState.inactive
    
    let minHeight: CGFloat = 100
    let snapThreshold: CGFloat = 200
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center, spacing: 0) {
                TopView(topViewHeight: $topViewHeight, title: menuItems.first(where: { $0.id == selectedMenu })?.name ?? "Inbox", count: menuItems.first(where: { $0.id == selectedMenu })?.count ?? "0")
                    .frame(width: geometry.size.width, height: topViewHeight)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 50, height: 10)
                        .scaleEffect(dragState.isDragging ? 0.8 : 1.0)
                        .foregroundColor(.gray.opacity(0.4))
                        .padding(.vertical, 10)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.dragState = .dragging(translation: gesture.translation)
                                    let dragAmount = gesture.translation.height
                                    let newHeight = max(minHeight, min(geometry.size.height - minHeight, topViewHeight + dragAmount))
                                    if newHeight != topViewHeight {
                                        topViewHeight = newHeight
                                    }
                                }
                                .onEnded { _ in
                                    self.dragState = .inactive
                                    withAnimation(.spring()) {
                                        let newHeight = topViewHeight
                                        if newHeight < minHeight + snapThreshold {
                                            topViewHeight = minHeight
                                        } else if (geometry.size.height - newHeight) < minHeight + snapThreshold {
                                            topViewHeight = geometry.size.height - minHeight
                                        }
                                    }
                                }
                        )
                    Spacer()
                }
                
                BottomView(menuItems: $menuItems, selectedMenu: $selectedMenu, topViewHeight: topViewHeight, totalHeight: geometry.size.height)
                    .frame(width: geometry.size.width, height: geometry.size.height - topViewHeight - 30)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                
            }
        }
        .ignoresSafeArea()
        .background(.black)
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

struct TopView: View {
    @State private var lastKnownOrientation = DeviceOrientation.portrait
    
    let motionManager = CMMotionManager()
    @State private var firstArrayIsActive = true
    @State private var people = people1
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    @State private var offset: Double = -75
    @State private var blur: Double = 25
    
    @Binding var topViewHeight: CGFloat
    let title: String
    let count: String
    let minHeight: CGFloat = 200
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if topViewHeight > minHeight {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Unread")
                        .font(.system(size: topViewHeight > minHeight ? 16 : 25 , weight: .bold))
                }
                
                Spacer()
                
                Text(count)
                    .font(.system(size: topViewHeight > minHeight ? 16 : 25 , weight: .bold, design: .rounded))
            }
            
            if topViewHeight > minHeight {
                ScrollView {
                    ForEach(people, id: \.id) { person in
                        HStack (alignment: .center, spacing: 16) {
                            Image(person.imageName)
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                            
                            VStack (alignment: .leading) {
                                HStack {
                                    Text(person.name)
                                        .font(.system(size: 16.0, weight: .bold, design: .rounded))
                                    
                                    Spacer()
                                    
                                    
                                    Text("\(person.time)")
                                        .opacity(0.5)
                                        .font(.system(size: 16.0, weight: .medium, design: .rounded))
                                    
                                }
                                
                                Text(person.post)
                                    .offset(y: 4)
                                    .font(.system(size: 16.0, design: .rounded))
                                
                            }
                        }
                        .padding()
                        .background(.gray.opacity(0.20))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .frame(maxWidth: .infinity, minHeight: 100, idealHeight: 100, maxHeight: 100)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .offset(y: offset)
                        .blur(radius: blur)
                        .onAppear {
                            withAnimation(.spring().delay(Double(person.id%5 + 1) * 0.5)) {
                                scale = 1
                                opacity = 1
                                offset = 0
                                blur = 0
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .onAppear {
                    if motionManager.isDeviceMotionAvailable {
                        motionManager.deviceMotionUpdateInterval = 0.02
                        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { (data, error) in
                            if let data = data {
                                
                                self.handleDeviceMotionUpdate(data)
                            }
                        }
                    }
                }
                .onDisappear {
                    motionManager.stopDeviceMotionUpdates()
                }
                .statusBarHidden(true)
            }
        }
        .padding([.top, .horizontal], 20)
        .font(.system(size: 16, weight: .medium, design: .rounded))
    }
    
    func handleDeviceMotionUpdate(_ data: CMDeviceMotion) {
        
        let gravity = data.gravity
        let upsideDown = gravity.z > 0.8
        let portrait = gravity.z < -0.8
        
        if upsideDown {
            lastKnownOrientation = .upsideDown
        } else if portrait && lastKnownOrientation == .upsideDown {
            lastKnownOrientation = .portrait
            withAnimation {
                withAnimation(.spring()) {
                    scale = 0
                    opacity = 0
                    offset = -75
                    blur = 25
                }
                self.people = firstArrayIsActive ? people2 : people1
                firstArrayIsActive.toggle()
                withAnimation(.spring()) {
                    scale = 1
                    opacity = 1
                    offset = 0
                    blur = 0
                }
            }
        }
    }
}

struct BottomView: View {
    @Binding var menuItems: [MenuItem]
    @Binding var selectedMenu: Int
    
    var topViewHeight: CGFloat
    let minHeight: CGFloat = 200
    let totalHeight: CGFloat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if totalHeight - topViewHeight - 30 > minHeight {
                ScrollView {
                    ForEach(menuItems, id: \.id) { item in
                        Button(action: {
                            self.selectedMenu = item.id
                        }) {
                            HStack {
                                Image(systemName: item.icon)
                                Text(item.name)
                                    .font(.system(size: 16.0, weight: .medium))
                                
                                Spacer()
                                
                                Text(item.count)
                                    .font(.system(size: 16.0, weight: .medium))
                            }.padding([.vertical], 6)
                            
                            Spacer()
                        }
                        .foregroundColor(Color(.label))
                        .padding([.horizontal], 5)
                        .padding([.vertical], 2)
                        .background(selectedMenu == item.id ? .gray.opacity(0.20) : Color.white.opacity(0.0))
                        .cornerRadius(6.0)
                    }
                }.scrollIndicators(.hidden)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(menuItems, id: \.id) { item in
                            Button(action: {
                                self.selectedMenu = item.id
                            }) {
                                HStack {
                                    Image(systemName: item.icon)
                                    Text(item.name)
                                        .font(.system(size: 16.0, weight: .medium))
                                }.underline(selectedMenu == item.id ? true : false)
                            }
                            .padding([.horizontal], 8)
                            .foregroundColor(Color(.label))
                            
                            
                        }
                        
                    }
                }.scrollIndicators(.hidden)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .font(.system(size: 16, weight: .medium
                      , design: .rounded))
    }
    
    func getDay(for index: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = Calendar.current.date(byAdding: .day, value: index, to: Date())!
        return dateFormatter.string(from: day)
    }
}



#Preview {
    ContentView()
}
