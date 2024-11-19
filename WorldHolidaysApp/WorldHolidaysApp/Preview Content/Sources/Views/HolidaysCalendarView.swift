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
            VStack {
                // Индикатор загрузки данных
                if isLoading {
                    ProgressView("Loading holidays...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .onChange(of: selectedDate) { _ in
                            updateTodayHoliday()
                        }
                    
                    // Отображение информации о празднике
                    if let holiday = todayHoliday {
                        HolidayDetailsView(holiday: holiday, showConfetti: $showConfetti)
                    } else {
                        Text("There's no holidays today.")
                            .font(.headline)
                            .padding()
                    }
                }
            }
            .navigationTitle("Holidays Calendar")
            .task {
                await loadHolidays()
            }
            .padding()
        }
    }
    
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

struct HolidayDetailsView: View {
    let holiday: Holiday
    @Binding var showConfetti: Bool
    
    var body: some View {
        VStack {
            Text("🎉 \(holiday.name) 🎉")
                .font(.headline)
                .padding()
            
            Button("Show Fun Fact") {
                withAnimation {
                    showConfetti.toggle()
                }
            }
            .padding()
            .buttonStyle(.borderedProminent)
            
            if showConfetti {
                Text(holiday.fact)
                    .font(.body)
                    .padding()
                    .transition(.scale)
                
                ConfettiView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .animation(.easeInOut, value: showConfetti)
        .padding()
    }
}

