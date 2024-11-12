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
                    
                    // Проверка, есть ли праздник на сегодняшний день
                    if let holiday = todayHoliday {
                        Text("Сегодня праздник: \(holiday.name)")
                            .font(.headline)
                            .padding()
                    } else {
                        Text("Сегодня нет праздников.")
                            .font(.headline)
                            .padding()
                    }
                }
            }
            .navigationTitle("Holiday Calendar")
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
        
        // Определяем сегодняшнюю дату без времени
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        // Находим праздник, который совпадает с сегодняшней датой
        todayHoliday = holidays.first { holiday in
            let holidayDate = calendar.startOfDay(for: holiday.date)
            return holidayDate == today
        }
        
        // Отладочная печать
        if let holiday = todayHoliday {
            print("It's a holiday today: \(holiday.name), Дата: \(holiday.date)")
        } else {
            print("There's no holidays today.")
        }
    }
}
