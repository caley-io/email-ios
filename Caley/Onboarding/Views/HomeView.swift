//
//  HomeView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct HomeView: View {
    @Binding var showNextView: Bool
    @State  var isExpanded = false
    @State  var startTyping = false
    @State var showtext = false
    var body: some View {
        ZStack{
         
            GeoView(isExpanded: $isExpanded, startTyping: $startTyping, showtext: $showtext, color: "black", text: "Start", shouldToggleExpand: false)
            
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showNextView: .constant(false))
    }
}
