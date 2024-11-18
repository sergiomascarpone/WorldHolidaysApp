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
                // Показать статус загрузки или пустой список
                if isLoading {
                    Text("Loading holidays...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if holidays.isEmpty {
                    Text("No holidays found for this year.")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Используем LazyVStack для оптимизации отображения
                    LazyVStack(spacing: 10) {
                        ForEach(holidays) { holiday in
                            HolidayRow(holiday: holiday)
                        }
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

struct HolidayRow: View {
    let holiday: Holiday
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Название праздника
            Text(holiday.name)
                .font(.headline)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
                .padding(.bottom, 4)
            
            // Изображение праздника
            HolidayImage(imageName: holiday.imageName)
            
            // Дата праздника
            Text(holiday.date.formatted(date: .long, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct HolidayImage: View {
    let imageName: String
    
    var body: some View {
        if let image = UIImage(named: imageName) {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: 100)
                .cornerRadius(10)
                .clipped()
        } else {
            Text("No Image Available")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
        }
    }
}

#Preview {
    HolidaysListView()
}
