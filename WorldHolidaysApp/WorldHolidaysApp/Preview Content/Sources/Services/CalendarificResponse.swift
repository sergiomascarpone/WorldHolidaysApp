//
//  CalendarificResponse.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import Foundation

// Главный ответ, получаемый от API Calendarific
struct CalendarificResponse: Codable {
    let meta: Meta
    let response: HolidaysResponse
    
    struct Meta: Codable {
        let code: Int
        let errorType: String?
        let errorDetail: String?
        
        enum CodingKeys: String, CodingKey {
            case code
            case errorType = "error_type"
            case errorDetail = "error_detail"
        }
    }
    
    struct HolidaysResponse: Codable {
        let holidays: [Holiday]
    }
    
    struct Holiday: Identifiable, Codable {
        var id: String { name } // Используем название праздника как уникальный идентификатор
        let name: String
        let description: String
        let country: Country
        let date: HolidayDate
        let type: [String]
        let primaryType: String
        
        enum CodingKeys: String, CodingKey {
            case name, description, country, date, type
            case primaryType = "primary_type"
        }
        
        struct Country: Codable {
            let id: String
            let name: String
        }
        
        struct HolidayDate: Codable {
            let iso: String
            let datetime: DateDetails
            
            struct DateDetails: Codable {
                let year: Int
                let month: Int
                let day: Int
            }
        }
    }
}
