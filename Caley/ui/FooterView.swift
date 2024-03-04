//
//  FooterView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/17/24.
//

import SwiftUI

struct FooterView: View {
    let open: Bool
    init(open: Bool) {
        self.open = open
    }
    var body: some View {
        VStack {
            if self.open {
                HStack {
                    VStack(spacing: 20) {
                        HStack {
                            Image(systemName: "book")
                            
                            Spacer()
                        }
                        .padding(15)
                        .background(.thinMaterial)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.white.opacity(0.1), lineWidth: 1)
                        )
                        
                        HStack(spacing: 20) {
                            VStack(spacing: 10) {
                                HStack {
                                    Image(systemName: "book")
                                }
                                .frame(width: 70, height: 70)
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.1), lineWidth: 1)
                                )
                                
                                Text("Mark read")
                                    .font(.system(size: 13))
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Image(systemName: "arrowshape.turn.up.left")
                                }
                                .frame(width: 70, height: 70)
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.1), lineWidth: 1)
                                )
                                
                                Text("Reply later")
                                    .font(.system(size: 13))
                            }
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Image(systemName: "archivebox")
                                }
                                .frame(width: 70, height: 70)
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.1), lineWidth: 1)
                                )
                                
                                Text("Archive")
                                    .font(.system(size: 13))
                            }
                            
                            
                            
                            VStack(spacing: 10) {
                                HStack {
                                    Image(systemName: "trash")
                                }
                                .frame(width: 70, height: 70)
                                .background(.thinMaterial)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(.white.opacity(0.1), lineWidth: 1)
                                )
                                
                                Text("Delete")
                                    .font(.system(size: 13))
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            
            Spacer()
        }
        .padding(23)
        .frame(height: self.open ? 250.0 : 80.0)
        .background(.thinMaterial)
        .cornerRadius(self.open ? 30 : 0, corners: [.topLeft, .topRight])
    }
}

#Preview {
    FooterView(open: true)
}
