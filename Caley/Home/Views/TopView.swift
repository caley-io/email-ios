//
//  TopView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct TopView: View {
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
            }
        }
        .padding([.top, .horizontal], 20)
        .font(.system(size: 16, weight: .medium, design: .rounded))
    }
}
