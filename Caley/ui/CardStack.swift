//
//  CardStack.swift
//  Caley
//
//  Created by Jeremy Scatigna on 04/03/2024.
//
import SwiftUI

struct CardStack: View {
    
    @State var cardOffset: CGFloat = 24
    @State var cardRatio: CGFloat = 1
    @State var cardOffsetMultiplier: CGFloat = 0.5
    @State var cardAlphaStep: Double = 0.1
    
    @Binding var isExpanded: Bool
    @Binding var isDetailsOpen: Bool
    
    @State var emails: [Mail] = []
    
    private var yCardsOffset: CGFloat
    {
        return -CGFloat(emails.count) * cardOffset / 2
    }
    
    private func calculateCardWidth(geo: GeometryProxy, offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return geo.size.width - ((offset * 2) * CGFloat(cardIndex))
    }
    
    private func calculateCardYOffset(offset: CGFloat, cardIndex: Int) -> CGFloat
    {
        return offset * CGFloat(cardIndex)
    }
    
    private func calculateItemInvertIndex(arr: [Mail], item: Mail) -> Int
    {
        if arr.isEmpty { return 0 }
        return arr.count - 1 - arr.firstIndex(of: item)!
    }
    
    private func calculateCardAlpha(cardIndex: Int) -> Double
    {
        return 1.0 - Double(cardIndex) * cardAlphaStep
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(emails.count) emails needs you attention")
                    .font(.system(size: 16, weight: .bold))
                    .padding([.leading, .trailing], 14)
                    .padding(.bottom, 14)
                
                Spacer()
                
                Image(systemName: "arrowtriangle.down.square.fill")
                    .rotationEffect(isExpanded ? .degrees(180) : .degrees(0))
                    .padding([.leading, .trailing], 14)
                    .padding(.bottom, 14)
                    .onTapGesture {
                        if (self.cardOffsetMultiplier == 0.5) {
                            self.cardOffsetMultiplier = 3.6
                            self.cardAlphaStep = 0.0
                            self.isExpanded = true
                        } else {
                            self.cardOffsetMultiplier = 0.5
                            self.cardAlphaStep = 0.1
                            self.isExpanded = false
                        }
                    }
                    .sensoryFeedback(.increase, trigger: self.isExpanded)
            }
            ZStack {
                ForEach (emails, id: \.id) {
                    day in
                    CardView(cardAlpha: calculateCardAlpha(cardIndex: calculateItemInvertIndex(arr: emails, item: day)), isExpanded: isExpanded)
                        .offset(x: 0, y: calculateCardYOffset(offset: cardOffset, cardIndex: calculateItemInvertIndex(arr: emails, item: day)) * cardOffsetMultiplier)
                        .padding([.leading, .trailing], 10)
                        .onTapGesture {
                            self.isDetailsOpen = true
                        }
                        .sensoryFeedback(.increase, trigger: self.isDetailsOpen)
                        
                }
            }
        }
        .padding(.top, 8)
        .onAppear(perform: loadEmails)
        .background(Color("Accent"))
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
