//
//  HolidaysCalendarView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct HolidaysCalendarView: View {
    @State private var holidays: [Holiday] = []
    @State private var selectedDate: Date = Date()
    @State private var todayHoliday: Holiday?
    @State private var isLoading = true
    @State private var showConfetti = false
    
    let service = HolidaysService()
    
    var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    ProgressView("Loading holidays...")
                } else {
                    VStack {
                        DatePicker(
                            LocalizationManager.shared.localizedString(forKey: "Select Date"),
                            selection: $selectedDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        
                        if let holiday = todayHoliday {
                            HolidayDetailsView(
                                holiday: holiday,
                                showConfetti: $showConfetti
                            )
                            .padding()
                        } else {
                            Text(LocalizationManager.shared.localizedString(forKey: "No holidays today."))
                                .font(.headline)
                                .foregroundColor(.secondary)
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle(LocalizationManager.shared.localizedString(forKey: "Holidays Calendar"))
            .task {
                await loadHolidays()
            }
        }
    }
    
    @MainActor
    private func loadHolidays() async {
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"
        isLoading = true
        holidays = await service.fetchHolidays(for: year, country: countryCode)
        isLoading = false
        
        updateTodayHoliday()
    }
    
    private func updateTodayHoliday() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: selectedDate)
        
        todayHoliday = holidays.first { holiday in
            let holidayDate = calendar.startOfDay(for: holiday.date)
            return holidayDate == today
        }
    }
}
