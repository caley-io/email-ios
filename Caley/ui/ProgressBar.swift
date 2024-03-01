//
//  ProgressBar.swift
//  Shyc
//
//  Created by Jeremy Scatigna on 15/04/2020.
//  Copyright © 2020 Jeremy Scatigna. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Int
    @Binding var numberOfStep: Int
    
    
    func calculateProgress() -> CGFloat {
        let calculatedValue: Double = Double(value) / Double(numberOfStep)
        return CGFloat(calculatedValue)
    }
    
    func getProgressBarWidth(geometry:GeometryProxy) -> CGFloat {
        let frame = geometry.frame(in: .global)
        return frame.size.width * calculateProgress()
    }
    
    func getPercentage(_ value:CGFloat) -> String {
        let intValue = Int(ceil(value * 100))
        return "\(intValue) %"
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .trailing) {
                Text("\(self.value) of \(self.numberOfStep)")
                    .padding(.bottom, 6)
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .heavy, design: .default))
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(UIColor.lightGray))
                        .frame(minWidth: 0, maxWidth: .infinity)
                    Capsule()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color("lightBg"), Color.purple]),
                            startPoint: .leading,
                            endPoint: .trailing))
                        .frame(minWidth: 0, idealWidth:self.getProgressBarWidth(geometry: geometry),
                               maxWidth: self.getProgressBarWidth(geometry: geometry))
                        .animation(.default)
                }
                .frame(height:10)
            }.frame(height:10)
        }.frame(height: 50)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProgressBar(value: .constant(2), numberOfStep: .constant(3))
        }.background(Color.black).padding(.all, 20)
    }
}
