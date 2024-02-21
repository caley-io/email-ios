//
//  TypingEffect.swift
//  Caley
//
//  Created by Jeremy Scatigna on 21/02/2024.
//

import SwiftUI

struct TypingEffect: View {
    @State private var displayedText = ""
    var fullText: String
    @State private var currentCharacterIndex: String.Index!
    @Binding var isExpanded: Bool
    var body: some View {
        VStack{
            Text(displayedText).font(.custom("Courier", size: 15))
                .foregroundColor(.black)
                .frame(width: 380, height: 150, alignment: .topLeading)
        }
        .onChange(of: isExpanded) { newValue in
            if newValue {
                startTypingEffect()
            }
        }
    }
    func startTypingEffect(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            currentCharacterIndex = fullText.startIndex
            Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
                displayedText.append(fullText[currentCharacterIndex])
                currentCharacterIndex = fullText.index(after: currentCharacterIndex)
                if currentCharacterIndex == fullText.endIndex{
                    timer.invalidate()
            }
            }
        }
    }
}

struct TypingEffect_Previews: PreviewProvider {
    static var previews: some View {
        TypingEffect(fullText:"""
               SwiftUI helps you build great-looking
               apps across all Apple platforms with
               the power of Swift — and surprisingly
               little code. You can bring even better ...

               """, isExpanded: .constant(false))
    }
}
