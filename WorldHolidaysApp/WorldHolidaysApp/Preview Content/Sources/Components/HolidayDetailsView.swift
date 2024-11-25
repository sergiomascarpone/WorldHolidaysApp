//
//  HolidayDetailsView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 25.11.24.
//

import SwiftUI

struct HolidayDetailsView: View {
    let holiday: Holiday
    @Binding var showConfetti: Bool

    var body: some View {
        VStack {
            Text("🎉 \(holiday.name) 🎉")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding()

            Button(LocalizationManager.shared.localizedString(forKey: "Show Fun Fact")) {
                withAnimation {
                    showConfetti.toggle()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)

            if showConfetti {
                Text(holiday.fact)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.scale)

                ConfettiView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color(.systemBackground).opacity(0.9))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding()
    }
}
