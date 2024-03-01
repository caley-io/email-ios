//
//  EmailView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/20/24.
//

import SwiftUI

struct EmailView: View {
    @State private var footerOpen = false
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                TitleView(title: "Todo")
//                AlirezaEmailView()
                VStack {
                    HStack(alignment: .top, spacing: 14) {
                        Image("ali")
                            .resizable()
                            .frame(width: 22, height: 22)
                            .clipShape(Circle())
                        
//                        Text("Alireza Bashiri")
//                            .font(.system(size: 16))
                        
                        
                        Text("This is a test email with really long, random text that means nothing. The goal is to establish an email thread page with multiple senders and receivers, and that displays information like subject, body, Cc, and Bcc.")
                            .font(.system(size: 16))
                        Spacer()
                        
//                        Text("3:53pm")
//                            .font(.system(size: 16))
//                            .foregroundStyle(.gray)
                    }
                    
                    HStack {
                        HStack {}
                            .frame(width: 15)
                        
                        
                    }
                }
                .padding(14)
                
                LazyVStack {
//                    ForEach(emails, id: \.id) { email in
//                        EmailListItemView(email: email)
//                            .onLongPressGesture {
//                                withAnimation(.spring()) {
//                                    self.footerOpen = true
//                                }
//                            }
//                    }
                }
                .padding([.leading, .trailing], 14)
            }
            .padding(.top, 65)
            .padding(.bottom, 85)
            .background(.highlight)
            .cornerRadius(20, corners: [.topLeft, .topRight])
            .onTapGesture {
                withAnimation(.spring()) {
                    self.footerOpen = false
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                Spacer()
                FooterView(open: false)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    EmailView()
}
