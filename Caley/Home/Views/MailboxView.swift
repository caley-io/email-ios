//
//  MailboxView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct MailboxView: View {
    @State private var topViewHeight: CGFloat = 480
    
    @State private var menuItems = menu
    @State public var selectedMenu = 1
    
    @State private var dragState = DragState.inactive
    
    let minHeight: CGFloat = 100
    let snapThreshold: CGFloat = 200
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack (alignment: .center, spacing: 0) {
                #if os(macOS)
                TopView(topViewHeight: $topViewHeight, title: menuItems.first(where: { $0.id == selectedMenu })?.name ?? "Inbox", count: menuItems.first(where: { $0.id == selectedMenu })?.count ?? "0")
                    .frame(width: geometry.size.width, height: topViewHeight)
                    .background(Color(NSColor.clear))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                #else
                TopView(topViewHeight: $topViewHeight, title: menuItems.first(where: { $0.id == selectedMenu })?.name ?? "Inbox", count: menuItems.first(where: { $0.id == selectedMenu })?.count ?? "0")
                    .frame(width: geometry.size.width, height: topViewHeight)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                #endif
                
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
                
                #if os(macOS)
                BottomView(menuItems: $menuItems, selectedMenu: $selectedMenu, topViewHeight: topViewHeight, totalHeight: geometry.size.height)
                    .frame(width: geometry.size.width, height: geometry.size.height - topViewHeight - 30)
                    .background(Color(NSColor.clear))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                #else
                BottomView(menuItems: $menuItems, selectedMenu: $selectedMenu, topViewHeight: topViewHeight, totalHeight: geometry.size.height)
                    .frame(width: geometry.size.width, height: geometry.size.height - topViewHeight - 30)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                #endif
                
            }
        }
        .ignoresSafeArea()
        .background(.black)
    }
}
