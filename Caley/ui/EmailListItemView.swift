//
//  EmailListItemView.swift
//  caley-ios
//
//  Created by Austin Wasson on 2/17/24.
//

import SwiftUI

struct EmailListItemView: View {
    let email: Mail
    init(email: Mail) {
        self.email = email
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack {
                Image(self.email.image)
                    .resizable()
                    .frame(width: 23, height: 23)
                    .clipShape(Circle())
                
                Spacer()
            }
            
            VStack(spacing: 4) {
                HStack {
                    
                    
                    Text(self.email.author)
                        .font(.system(size: 14, weight: .medium))
//                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text("2:29pm")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text(self.email.subject)
                        .font(.system(size: 13, weight: .medium))
//                        .foregroundStyle(.white)
                    
                    
                    
                    Spacer()
                }
                
                HStack {
                    Text(self.email.body)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(.gray)
                        .lineLimit(1)
                        .truncationMode(.tail)
                    
                    Spacer()
                    HStack {
                        Image(systemName: "book.pages")
                            .font(.system(size: 13))
                        Text("2 min")
                            .font(.system(size: 13))
                    }
                }
            }
        }
        .padding(.bottom, 7)
    }
}


//#Preview {
//    EmailListItemView(email: {
//        "id": 1,
//        "subject": "Set launch date",
//        "body": "Hey! Let's brainstorm a launch date",
//        "author": "Jeremy Scatigna",
//        "image": "jeremy"
//      })
//}
