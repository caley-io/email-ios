//
//  TopView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI
import SwiftData

struct TopView: View {
    @State private var scale: CGFloat = 0
    @State private var opacity: Double = 0
    @State private var offset: Double = -75
    @State private var blur: Double = 25
    
    @AppStorage("lastActionsFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Action.id) private var actions: [Action]
    
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Todo")
                        .font(.system(size: 16, weight: .bold))
                }
                
                Spacer()
            }
            
            ScrollView {
                ForEach(actions, id: \.id) { action in
                    HStack (alignment: .center, spacing: 16) {
                        AsyncImage(url: .init(string: action.userAvatar)) { image in
                            image
                                .resizable()
                                .frame(width: 48, height: 48)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Text(action.from)
                                    .font(.system(size: 16.0, weight: .bold, design: .rounded))
                                
                                Spacer()
                            }
                            
                            Text(action.title)
                                .offset(y: 4)
                                .font(.system(size: 16.0, design: .rounded))
                        }
                    }
                    .padding()
                    .background(.gray.opacity(0.20))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .scrollIndicators(.hidden)
            
        }
        .padding([.top], 20)
        .font(.system(size: 16, weight: .medium, design: .rounded))
        .task {
            do {
                isLoading = true
                defer { isLoading = false }
                
                if hasExceededFetchLimit() || actions.isEmpty {
                    try clearActions()
                    try await fetchActions()
                }
            } catch {
                print(error)
            }
        }
        .overlay {
            if isLoading {
                ProgressView()
            }
        }
    }
}

private extension TopView {
    
    func clearActions() throws {
        _ = try modelContext.delete(model: Action.self)
    }
    
    func fetchActions() async throws {
        let url = URL(string: "https://mockend.com/api/caley-io/caley-app/actions")!
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let actions = try JSONDecoder().decode([Action].self, from: data)
        
        actions.forEach { modelContext.insert($0) }
        
        lastFetched = Date.now.timeIntervalSince1970
    }
    
    func hasExceededFetchLimit() -> Bool {
        
        let timeLimit = 300 // 5 mins
        let currentTime = Date.now
        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
        
        guard let differenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else {
            return false
        }
        return differenceInMins >= timeLimit
    }
    
}
