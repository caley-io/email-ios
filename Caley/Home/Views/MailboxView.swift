//
//  MailboxView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct Mail: Codable, Equatable {
    let id: Int
    let subject: String
    let body: String
    let author: String
    let image: String
}

struct MailboxView: View {
    @State private var footerOpen: Bool = false
    @State private var footerHeight: CGFloat = 80
    @State var emails: [Mail] = []
    
    var body: some View {
        VStack {
            TitleView(title: "All Emails")
            ScrollView {
                ForEach(emails, id: \.id) { email in
                    EmailListItemView(email: email)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35)) {
                                self.footerOpen = !self.footerOpen
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            .padding([.leading, .trailing], 14)
        }
        .padding(.top, 25)
        .padding(.bottom, 85)
        .background(.highlight)
        .cornerRadius(20, corners: [.topLeft, .topRight])
        .onAppear(perform: loadEmails)
        .edgesIgnoringSafeArea(.all)
        
        
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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundSpecificCorners(radius: radius, corners: corners) )
    }
}

struct RoundSpecificCorners: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
