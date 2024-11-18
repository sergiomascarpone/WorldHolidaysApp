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
//                // Фоновый блюр
//                VisualEffectBlur(blurStyle: .systemMaterial)
//                    .ignoresSafeArea()

                VStack {
                    if isLoading {
                        ProgressView("Loading holidays...")
                    } else {
                        DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                        
                        if let holiday = todayHoliday {
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
                        } else {
                            Text("There's no holidays today.")
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
    }

    private func loadHolidays() async {
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"
        
        isLoading = true
        holidays = await service.fetchHolidays(for: year, country: countryCode)
        isLoading = false
        
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        todayHoliday = holidays.first { holiday in
            let holidayDate = calendar.startOfDay(for: holiday.date)
            return holidayDate == today
        }
    }
}
