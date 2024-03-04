//
//  CardView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 04/03/2024.
//

import SwiftUI

struct CardView: View {
    var cardAlpha: Double = 1.0
    var isExpanded: Bool
    
    @State private var translation: CGSize = .zero
    @State private var motionOffset: Double = 0.0
    @State private var motionScale: Double = 0.0
    
    var body: some View {
        GeometryReader {
            geometry in
            HStack(alignment: .top, spacing: 10) {
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Image("ali")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        Text("Alireza Bashiri")
                            .font(.system(size: 14, weight: .medium))
                    }
                    
                    Text("Research the MX record limit on Hetzner and figure out number of instances necessary.")
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.8))
                }
                
                Spacer()
                
            }
            .padding(9)
            .background(.gray)
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(.white.opacity(0.3), lineWidth: 1)
            )
            .opacity(cardAlpha)
            .shadow(
                color: isExpanded ? Color(.highlight).opacity(0)  : Color(.highlight),
                radius: isExpanded ? 0 : CardViewConsts.cardShadowBlur,
                x: 0,
                y: isExpanded ? 0 : CardViewConsts.cardShadowOffset
            )
            .rotationEffect(
                .degrees(Double(self.translation.width / geometry.size.width * CardViewConsts.cardRotLimit)),
                anchor: .bottom
            )
            .offset(x: self.translation.width, y: self.translation.height)
            .animation(.interactiveSpring(
                response: CardViewConsts.springResponse,
                blendDuration: CardViewConsts.springBlendDur)
            )
            .gesture(
                DragGesture()
                    .onChanged {
                        gesture in
                        self.translation = gesture.translation
                        self.motionOffset = Double(gesture.translation.width / geometry.size.width)
                    }
                    .onEnded {
                        gesture in
                        self.translation = .zero
                        self.motionScale = 0.0
                    }
            )
            
        }
        
    }
}

private struct CardViewConsts
{
    static let cardRotLimit: CGFloat = 20.0
    static let poopTriggerZone: CGFloat = -0.1
    static let loveTriggerZone: CGFloat = 0.1
    
    static let cardRatio: CGFloat = 1.333
    static let cardCornerRadius: CGFloat = 24.0
    static let cardShadowOffset: CGFloat = 16.0
    static let cardShadowBlur: CGFloat = 16.0
    
    static let labelTextSize: CGFloat = 24.0
    static let labelTextKerning: CGFloat = 6.0
    
    static let motionRemapFromMin: Double = 0.0
    static let motionRemapFromMax: Double = 0.25
    static let motionRemapToMin: Double = 0.0
    static let motionRemapToMax: Double = 1.0
    
    static let springResponse: Double = 0.5
    static let springBlendDur: Double = 0.3
    
    static let iconSize: CGSize = CGSize(width: 96.0, height: 96.0)
}

#Preview {
    CardView(isExpanded: false)
}
