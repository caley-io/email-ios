//
//  BottomView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

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
                        #if os(macOS)
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
                        
                        .foregroundColor(Color(NSColor.labelColor))
                        .padding([.horizontal], 5)
                        .padding([.vertical], 2)
                        .background(selectedMenu == item.id ? .gray.opacity(0.20) : Color.white.opacity(0.0))
                        .cornerRadius(6.0)
                        
                        #else
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
                        #endif
                    }
                }.scrollIndicators(.hidden)
            } else {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(menuItems, id: \.id) { item in
                            #if os(macOS)
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
                            .foregroundColor(Color(NSColor.labelColor))
                            #else
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
                            #endif
                            
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
