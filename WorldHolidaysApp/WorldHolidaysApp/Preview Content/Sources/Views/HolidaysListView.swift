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
            ZStack {
                if isLoading {
                    ProgressView("Loading holidays...")
                } else {
                    ScrollView {
                        LazyVStack(spacing: 10) { // LazyVStack заменяет многослойные List
                            ForEach(holidays) { holiday in
                                HolidayRow(holiday: holiday)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle(LocalizationManager.shared.localizedString(forKey: "Holidays List"))
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
