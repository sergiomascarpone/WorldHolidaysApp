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
    @State private var isLoading = true
    let service = HolidaysService()
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading holidays...")
                } else {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    
                    List(filteredHolidays) { holiday in
                        VStack(alignment: .leading) {
                            Text(holiday.name)
                                .font(.headline)
                            Text(holiday.date.formatted(date: .long, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Holiday Calendar")
            .task {
                await loadHolidays()
            }
        }
    }
    
    private var filteredHolidays: [Holiday] {
        holidays.filter { holiday in
            let calendar = Calendar.current
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(abbreviation: "UTC")
            
            // Преобразуем обе даты в формат "yyyy-MM-dd" с учетом времени UTC
            let holidayString = formatter.string(from: holiday.date)
            let selectedDateString = formatter.string(from: selectedDate)

            // Логируем для проверки
            print("Selected Date (UTC): \(selectedDateString), Holiday Date (UTC): \(holidayString)")

            // Сравниваем только дату
            return holidayString == selectedDateString
        }
    }
    
    private func loadHolidays() async {
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"
        holidays = await service.fetchHolidays(for: year, country: countryCode)
        
        // Логируем даты
        print("Selected Date: \(selectedDate)")
        holidays.forEach { holiday in
            print("Holiday: \(holiday.name), Date: \(holiday.date)")
        }
        
        isLoading = false
    }
}

