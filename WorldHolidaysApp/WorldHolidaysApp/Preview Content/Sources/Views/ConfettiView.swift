//
//  ConfettiView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 18.11.24.
//

import SwiftUI

struct ConfettiView: View {
    @State private var isAnimating = false
    let colors: [Color] = [.red, .yellow, .blue, .green, .pink, .purple]
    
    var body: some View {
        ZStack {
            ForEach(0..<100, id: \.self) { i in
                Circle()
                    .fill(colors.randomElement()!)
                    .frame(width: 10, height: 10)
                    .opacity(isAnimating ? 0 : 1)
                    .scaleEffect(isAnimating ? 0.5 : 1)
                    .offset(
                        x: CGFloat.random(in: -200...200),
                        y: CGFloat.random(in: -200...200)
                    )
                    .animation(
                        Animation.easeOut(duration: 1.5)
                            .repeatForever(autoreverses: false)
                            .delay(Double(i) * 0.05),
                        value: isAnimating
                    )
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

//#Preview {
//    ConfettiView()
//}
