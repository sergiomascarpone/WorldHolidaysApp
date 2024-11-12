//
//  ContentView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct HolidaysListView: View {
    @State private var holidays: [Holiday] = []

    var body: some View {
        NavigationView {
            List(holidays) { holiday in
                NavigationLink(destination: HolidayDetailView(holiday: holiday)) {
                    Text(holiday.name)
                }
            }
            .navigationTitle("Holidays")
            .task {
                holidays = await HolidaysService.fetchHolidays(for: Calendar.current.component(.year, from: Date()))
            }
        }
    }
}

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

#Preview {
    HolidaysListView()
}
