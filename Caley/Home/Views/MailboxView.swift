//
//  MailboxView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 20/02/2024.
//

import SwiftUI

struct MailboxView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            TopView()
                
            BottomView()
            
        }
        .padding([.top, .horizontal], 20)
        .font(.system(size: 16, weight: .medium, design: .rounded))
    }
}
