//
//  AlirezaEmailView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/19/24.
//

import SwiftUI

struct AlirezaEmailView: View {
    var body: some View {
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
    AlirezaEmailView()
}
