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

extension Holiday {
    var imageName: String {
        switch name.lowercased() {
        case "new year's day":
            return "new_year"
        case "christmas":
            return "christmas_tree"
        case "independence day":
            return "independence_day"
        default:
            return "default_holiday"
        }
    }
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
