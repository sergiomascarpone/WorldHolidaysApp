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
        case "new year holiday":
            return "new_year_holiday"
        case "orthodox christmas day":
            return "orthodox_christmas_day"
        case "valentine's day":
            return "valentines_day"
        case "defender of the fatherland day":
            return "defender_of_the_fatherland_day"
        case "women's day":
            return "women's_day"
        case "catholic christmas day":
            return "catholic_christmas_day"
        case "new year's eve":
            return "new_year's_eve"
        default:
            return "default_holiday"
        }
    }
}
