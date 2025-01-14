//
//  HolidaysService.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import Foundation

class HolidaysService {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "HOLIDAYS_API_KEY") as? String ?? ""
    private let cacheManager = LocalCacheManager()

    // Примеры интересных фактов о праздниках
    private let holidayFacts: [String] = [
        "Did you know? New Year's Day is the oldest of all holidays, being first observed in ancient Babylon about 4,000 years ago.",
        "Catholic Christmas Day is celebrated by over 2 billion people every year, across 160 countries.",
        "Christmas is celebrated by over 2 billion people every year, across 160 countries.",
        "The first Thanksgiving was celebrated in 1621 over a three-day harvest festival.",
        "Halloween is the second highest-grossing commercial holiday after Christmas.",
        "Valentine's Day is named after Saint Valentine, a Catholic priest who lived in Rome in the 3rd century."
    ]
    
    // Пока работает некоректно
    func fetchHolidays(for year: Int, country: String) async -> [Holiday] {
        guard URL(string: "https://calendarific.com/api/v2/holidays?api_key=\(apiKey)&country=\(country)&year=\(year)") != nil else {
            print("Ошибка формирования URL")
            return [
                Holiday(id: UUID(), name: "New Year's Day", date: Date(), description: "A global celebration for the start of the new year.", countryCode: country, fact: getRandomFact()),
                Holiday(id: UUID(), name: "Catholic Christmas Day", date: Calendar.current.date(from: DateComponents(year: year, month: 12, day: 25))!, description: "A Christian holiday that celebrates the birth of Jesus Christ.", countryCode: country, fact: getRandomFact())
            ]
        }
        let cachedHolidays = cacheManager.loadHolidays()
               if !cachedHolidays.isEmpty {
                   print("Используем кэшированные данные")
                   return cachedHolidays
               }
        // Если кэш пуст, загрузить данные с сервера
        guard let url = URL(string: "https://calendarific.com/api/v2/holidays?api_key=\(apiKey)&country=\(country)&year=\(year)") else {
            print("Ошибка формирования URL")
            return []
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Печать JSON ответа для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            }
            
            // Декодирование с учетом правильной модели
            let response = try JSONDecoder().decode(CalendarificResponse.self, from: data)
            if response.meta.code == 200 {
                let holidays = response.response.holidays.map { holiday in
                    Holiday(
                        id: UUID(),
                        name: holiday.name,
                        date: parseDate(from: holiday.date.datetime),
                        description: holiday.description,
                        countryCode: holiday.country.id,
                        fact: getRandomFact()
                    )
                }
                print("Загружено праздников: \(holidays.count)")
                // Сохранить загруженные данные в кэш!!
                              cacheManager.saveHolidays(holidays)
                return holidays
            } else {
                print("Ошибка в ответе от API: \(response.meta.code)")
                return []
            }
        } catch {
            print("Ошибка загрузки данных: \(error)")
            return []
        }
    }
    
    // Функция для корректного парсинга даты
    private func parseDate(from dateDetails: CalendarificResponse.Holiday.HolidayDate.DateDetails) -> Date {
        let calendar = Calendar.current
        let components = DateComponents(year: dateDetails.year, month: dateDetails.month, day: dateDetails.day)
        return calendar.date(from: components) ?? Date()
    }
    
    // Функция для получения случайного факта
    private func getRandomFact() -> String {
        return holidayFacts.randomElement() ?? "Enjoy your holiday!"
    }
}
