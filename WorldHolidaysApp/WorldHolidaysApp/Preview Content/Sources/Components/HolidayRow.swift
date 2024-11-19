//
//  HolidayRow.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 19.11.24.
//

import SwiftUI

struct HolidayRow: View {
    let holiday: Holiday

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Название праздника
            Text(holiday.name)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)

            // Изображение праздника
            HolidayImage(imageName: holiday.imageName)

            // Дата праздника
            Text(holiday.date.formatted(date: .long, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground).opacity(0.9))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

