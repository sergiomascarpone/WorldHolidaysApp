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
                        VStack(alignment: .leading, spacing: 10) {
                            // Название праздника
                            Text(holiday.name)
                                .font(.headline)
                                .lineLimit(2) // Ограничение на 2 строки
                                .minimumScaleFactor(0.8) // Уменьшение шрифта, если текст не вмещается
                                .padding(.bottom, 4)
                            
                            // Изображение праздника
                            if let image = UIImage(named: holiday.imageName) {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: .infinity, maxHeight: 60)
                                    .cornerRadius(10)
                                    .clipped()
                            } else {
                                Text("No Image Available")
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, maxHeight: 40)
                                    .background(Color.gray.opacity(0.3))
                                    .cornerRadius(10)
                            }
                            
                            // Дата праздника
                            Text(holiday.date.formatted(date: .long, time: .omitted))
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle(Text(LocalizationManager.shared.localizedString(forKey: "Holidays List")))
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
