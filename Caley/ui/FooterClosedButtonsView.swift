//
//  FooterClosedButtonsView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/20/24.
//

import SwiftUI

struct FooterClosedButtonsView: View {
    var body: some View {
        HStack(alignment: .top) {
            HStack {
                Image("austin")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            }
            .frame(width: 35, height: 35)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .padding(.top, 1)
            
            Spacer()
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .frame(width: 60, height: 35)
            .background(.ultraThinMaterial)
            .background(.ultraThinMaterial)
            .background(.ultraThinMaterial)
            .clipShape(Capsule())
            
            Spacer()
            
            HStack {
                Image(systemName: "chevron.up")
            }
            .frame(width: 35, height: 35)
            .background(.ultraThinMaterial)
            .background(.ultraThinMaterial)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
            .padding(.top, 1)
            
        }
    }
}

#Preview {
    FooterClosedButtonsView()
}
