//
//  JeremyEmailView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/19/24.
//

import SwiftUI

struct JeremyEmailView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image("jeremy")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                    
                    Text("Jeremy Scatigna")
                        .font(.system(size: 14, weight: .medium))
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 12))
                            .foregroundColor(.teal)
                        
                        Text("3")
                            .font(.system(size: 14))
                            .foregroundStyle(.teal)
                    }
                }
                
                Text("Design logos for the iOS and desktop apps and establish branding for Twitter/Discord.")
                    .font(.system(size: 14))
                    .foregroundStyle(.white.opacity(0.8))
            }
        }
        .padding(9)
        .background(.gray.opacity(0.5))
        .cornerRadius(14)
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
        .padding([.leading, .trailing], 10)
    }
}

#Preview {
    JeremyEmailView()
}
