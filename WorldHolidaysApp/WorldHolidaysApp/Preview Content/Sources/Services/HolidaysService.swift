//
//  HolidaysService.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import Foundation

class HolidaysService {
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "HOLIDAYS_API_KEY") as? String ?? ""

    func fetchHolidays(for year: Int, country: String) async -> [Holiday] {
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
                    Holiday(id: UUID(),
                            name: holiday.name,
                            date: parseDate(from: holiday.date.datetime),
                            description: holiday.description ?? "No description available",
                            countryCode: holiday.country.id)
                }
                print("Загружено праздников: \(holidays.count)")
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
}



//struct CalendarificResponse: Codable {
//    let meta: Meta
//    let response: Response
//}
//
//struct Meta: Codable {
//    let code: Int
//}
//
//struct Response: Codable {
//    let holidays: [HolidayResponse]
//}
//
//struct HolidayResponse: Codable {
//    let name: String
//    let description: String
//    let country: Country
//    let date: DateInfo
//}
//
//struct Country: Codable {
//    let id: String
//    let name: String
//}
//
//struct DateInfo: Codable {
//    let iso: String
//    let datetime: HolidayDate
//}
//
//struct HolidayDate: Codable {
//    let year: Int
//    let month: Int
//    let day: Int
//}
