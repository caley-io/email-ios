//
//  TitleView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/19/24.
//

import SwiftUI

struct TitleView: View {
    let title: String
    init(title: String) {
        self.title = title
    }
    
    var body: some View {
        HStack {
            Text(self.title)
                .font(.system(size: 16, weight: .medium))
                .padding([.leading, .trailing], 14)
                .padding(.bottom, 14)
            
            Spacer()
        }
        .padding(.top, 10)
    }
}

#Preview {
    TitleView(title: "Title")
}
