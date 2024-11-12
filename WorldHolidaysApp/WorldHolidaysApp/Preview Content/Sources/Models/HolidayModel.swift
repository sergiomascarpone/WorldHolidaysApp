//
//  HolidayModel.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import Foundation

struct Holiday: Identifiable {
    var id: UUID
    var name: String
    var date: Date
    var description: String
    var countryCode: String
}


//// Пример сервиса для загрузки данных (пока заглушка)
//class HolidayService {
//    // Заглушка данных
//    static func fetchHolidays(for year: Int) async -> [Holiday] {
//        return [
//            Holiday(id: UUID(), name: "New Year", date: Date(), description: "Celebration of the new year", countryCode: "US"),
//            Holiday(id: UUID(), name: "Christmas", date: Date(), description: "Christmas holiday", countryCode: "DE")
//        ]
//    }
//}
