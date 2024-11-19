//
//  HolidayDetailView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct HolidayDetailView: View {
    var holiday: Holiday
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text(holiday.name)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                // Показываем изображение в развернутом формате
                Image(holiday.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .cornerRadius(12)
                
                Text(holiday.description!)
                    .font(.body)
                    .padding(.horizontal)
                    .lineLimit(nil) // Разрешаем многострочный текст
                
                Spacer()
            }
            .padding()
            .navigationTitle("Holiday Details")
        }
    }
}


