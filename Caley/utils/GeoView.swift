//
//  GeoView.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct GeoView: View {
    // Binding variables - These allow the state to be managed outside this view but also allow this view to update the state.
    @Binding var isExpanded: Bool // Determines if the view is expanded or not
    @Binding var startTyping: Bool // Determines if the typing effect should start
    @Binding var showtext: Bool // Determines if the text should be shown or not
    
    @EnvironmentObject private var auth: MockAuthModel
    
    // Regular variables - Used to modify the appearance and behavior of the view.
    var color: String // Color for the circular view
    var text: String = "NEXT" // Text displayed on the button
    var showNextView: Binding<Bool>? // Binding to determine if the next view should be shown. Optional since it's not always required.
    
    // Variable to determine if the view should toggle between expanded and collapsed states on tap. Default is true.
    var shouldToggleExpand: Bool = true
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Circle().foregroundColor(Color(color))
                    .frame(width: isExpanded ? max(geometry.size.width ,geometry.size.height) * 1.5 : 200,
                           height:  isExpanded ? max(geometry.size.width ,geometry.size.height) * 1.5 : 200)
                // Display the "NEXT" text and arrow icon if the view is not expanded
                if !isExpanded{
                    HStack{
                        Text(text)
                        Image(systemName: "arrow.right")
                    }.bold().font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottomTrailing)
            .offset(x: isExpanded ? -250 : 40, y: isExpanded ? -150 : 20) // Offset to adjust position
            
            
        }
        .onTapGesture {
            if text == "Start" {
                auth.signIn()
            }
            // Animate the view's state changes
            withAnimation(.spring(response: 0.9, dampingFraction: 0.8)){
                // Toggle the isExpanded state based on the shouldToggleExpand variable
                if shouldToggleExpand{
                    isExpanded .toggle()
                }else{
                    isExpanded = true
                }
                // Toggle other states related to display and animation

                showtext.toggle()
                startTyping = true
                
                // If there's a binding for showing the next view, toggle its value after a brief delay
                if let showNextViewBinding = showNextView{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        showNextViewBinding.wrappedValue.toggle()
                    }
                }
                
            }
          
        }
    }
}
