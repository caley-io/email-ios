//
//  FirstView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct FirstView: View {
    @Binding var showNextView: Bool
    @State  var isExpanded = false
    @State  var startTyping = false
    @State var showtext = false
    var body: some View {
        ZStack{
            GeoView(isExpanded: $isExpanded, startTyping: $startTyping, showtext: $showtext, color: "fview", showNextView: $showNextView)
            VStack(alignment: .leading){
                Text("Swiftui \nFramework").font(.system(size: 50)).bold()
                TypingEffect(fullText: """
                       SwiftUI helps you build great-looking
                       
                       apps across all Apple platforms with
                       
                       the power of Swift — surprisingly
                       
                       little code. You can bring even better...

                       """, isExpanded: $startTyping)
            }
            .opacity(isExpanded ? 1 : 0 )
            .scaleEffect(isExpanded ? 1 : 0)
            .offset(x: showtext ? 0 : UIScreen.main.bounds.width)
            
        }
        .ignoresSafeArea()
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(showNextView: .constant(false))
    }
}
