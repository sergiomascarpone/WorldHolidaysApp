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
        VStack(alignment: .leading, spacing: 10) {
            Text(holiday.name)
                .font(.title)
            Text(holiday.description)
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}
