//
//  SplitView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 01/03/2024.
//

import SwiftUI
import VerticalSplit

struct SplitView: View {
    @State var saturation: CGFloat = 0.5
    @State var contrast: CGFloat = 0.5
    @State var shadows: CGFloat = 0.5
    @State var rotate: CGFloat = 0.5
    
    @State var detent: SplitDetent = .topFull
    
    @State var isAuto = false
    @State var isFilled = false
    
    @State var isExpanded = false
    @State var isDetailsOpen = false
    @State var isComposeOpen = false
    @State var isSeachOpen = false
    
    @State var selectedDetent: PresentationDetent = .height(250)
    
    var body: some View {
        VerticalSplit(
            detent: $detent,
            topTitle: "Needs Attention",
            bottomTitle: "All Emails",
            topView: {
                VStack {
                    
                    if (isExpanded == false) {
                        TitleView(title: "Todo")
                        AlirezaEmailView()
                            .onTapGesture {
                                self.isDetailsOpen = true
                            }
                            .sensoryFeedback(.increase, trigger: self.isDetailsOpen)
                        
                        JeremyEmailView()
                            .onTapGesture {
                                self.isDetailsOpen = true
                            }
                            .sensoryFeedback(.increase, trigger: self.isDetailsOpen)
                        
                        Spacer()
                    }
                    VStack {
                        CardStack(isExpanded: $isExpanded, isDetailsOpen: $isDetailsOpen)
                            .padding(.top, 8)
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
                .frame(maxHeight: .infinity)
                .ignoresSafeArea(edges: .horizontal)
            },
            bottomView: {
                MailboxView()
            },
            topMiniOverlay: {
                HStack {
                    Image(systemName: "eye.trianglebadge.exclamationmark.fill")
                    Text("Needs Attention")
                        .fontWeight(.medium)
                }
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
            },
            bottomMiniOverlay: {
                HStack {
                    Image(systemName: "envelope.open.badge.clock")
                    Text("All Emails")
                        .fontWeight(.medium)
                }
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
            }
        )
        .leadingAccessories([
            .init(systemName: "square.and.pencil.circle.fill", action: {
                self.isComposeOpen = true
            }),
            .init(systemName: "magnifyingglass.circle.fill", action: {
                self.isSeachOpen = true
            })
        ])
        .trailingAccessories([
            .init(systemName: "arrow.counterclockwise.circle.fill", action: {
                withAnimation(.smooth(duration: 0.4)) {
                    saturation = 0.5
                    contrast = 0.5
                    shadows = 0.5
                    rotate = 0.5
                    isAuto = false
                }
            })
        ])
        .menuAccessories([
            .init(title: "Markup", systemName: "pencil.tip.crop.circle") {
                detent = .topFull
            },
            .init(
                title: isFilled ? "Fit" : "Fill",
                systemName: isFilled ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right"
            ) {
                withAnimation(.smooth(duration: 0.6)) {
                    isFilled.toggle()
                }
            },
            .init(
                title: isAuto ? "Manual" : "Auto",
                systemName: "wand.and.stars",
                color: isAuto ? .yellow : .white
            ) {
                withAnimation(.smooth(duration: 0.4)) {
                    if isAuto {
                        saturation = 0.5
                        contrast = 0.5
                        shadows = 0.5
                        rotate = 0.5
                    } else {
                        saturation = 0.65
                        contrast = 0.55
                        shadows = 0.8
                        rotate = 0.46
                    }
                    isAuto.toggle()
                }
            },
        ])
        .debug(true)
        .backgroundColor(.init(uiColor: UIColor(white: 0.16, alpha: 1)))
        .sheet(isPresented: self.$isDetailsOpen, content: {
            Text("Details")
                .presentationDetents([.height(250), .large], selection: $selectedDetent)
        })
        .sheet(isPresented: self.$isComposeOpen, content: {
            Text("Compose")
                .presentationDetents([.large], selection: $selectedDetent)
        })
        .sheet(isPresented: self.$isSeachOpen, content: {
            Text("Search")
                .presentationDetents([.large], selection: $selectedDetent)
        })
    }
}

struct CustomSlider: View {
    let title: String
    @Binding var value: CGFloat
    let makeLabel: (CGFloat) -> String
    @GestureState var initialValue: CGFloat?
    @State var width: CGFloat = 0
    let size: CGFloat = 32
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                Spacer()
                Text(makeLabel(value))
                    .contentTransition(.numericText(value: value))
                    .monospacedDigit()
            }
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .padding(.horizontal, size / 2)
            ZStack(alignment: .leading) {
                Color.primary.opacity(0.1)
                Color.primary.opacity(0.2)
                    .clipShape(.capsule)
                    .overlay(alignment: .trailing) {
                        Circle()
                            .fill(.white)
                            .shadow(color: .black.opacity(0.2), radius: 8)
                            .padding(4)
                    }
                    .frame(width: size + (width - size) * value)
            }
            .clipShape(.capsule)
            .background {
                GeometryReader(content: { geometry in
                    Color.clear.onAppear {
                        width = geometry.size.width
                    }
                })
            }
            .gesture(
                DragGesture(coordinateSpace: .global)
                    .updating($initialValue, body: { v, s, _ in
                        if s == nil {
                            s = value
                        }
                    })
                    .onChanged({ v in
                        withAnimation(.smooth(duration: 0.2)) {
                            value = max(0, min(1, (initialValue ?? 0) + v.translation.width / (width - size)))
                        }
                    })
            )
            .frame(height: size)
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SplitView()
}
