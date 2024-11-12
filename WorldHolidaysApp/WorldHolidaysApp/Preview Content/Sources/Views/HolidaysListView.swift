//
//  ContentView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct HolidaysListView: View {
    @State private var holidays: [Holiday] = []
    @State private var isLoading = true
    let service = HolidaysService()

    var body: some View {
        NavigationView {
            List {
                if isLoading {
                    Text("Loading holidays...")
                } else if holidays.isEmpty {
                    Text("No holidays found for this year.")
                } else {
                    ForEach(holidays) { holiday in
                        VStack(alignment: .leading) {
                            Text(holiday.name)
                                .font(.headline)
                            // Используем правильный формат для даты праздника
                            Text(holiday.date, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Holidays List")
            .task {
                await loadHolidays()
            }
        }
    }

    private func loadHolidays() async {
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"
        isLoading = true
        holidays = await service.fetchHolidays(for: year, country: countryCode)
        isLoading = false
        print("Всего праздников загружено: \(holidays.count)")
    }
}


#Preview {
    HolidaysListView()
}
