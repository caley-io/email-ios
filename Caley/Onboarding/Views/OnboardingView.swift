//
//  OnboardingView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var showSview = false
    @State private var showTview = false
    @State private var showFview = false
    var body: some View {
        ZStack {
            Text("Swiftui Onboarding").bold().font(.largeTitle)
                .offset(y: -100)
                .padding(.leading,8)
            
            FirstView(showNextView: $showSview)
            SecondView(showNextView: $showTview)
                .modifier(ViewAnimation(isShow: showSview))
            HomeView(showNextView: $showTview)
                .modifier(ViewAnimation(isShow: showTview))
        }
    }
}

#Preview {
    OnboardingView()
}

struct ViewAnimation: ViewModifier{
    
    var isShow:Bool
    func body(content: Content) -> some View {
        content
            .offset(x:  isShow ? 0 : 200)
            .scaleEffect(isShow ? 1 : 0, anchor: .bottomTrailing)
            .animation(.spring(), value: isShow)
    }
     
}
