//
//  LocalCacheManager.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 19.11.24.
//

import Foundation

class LocalCacheManager {
    private let holidaysKey = "cachedHolidays"

    // Сохранение данных в UserDefaults
    func saveHolidays(_ holidays: [Holiday]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(holidays)
            UserDefaults.standard.set(data, forKey: holidaysKey)
            print("Holidays успешно сохранены в кэш")
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
        }
    }

    // Загрузка данных из UserDefaults
    func loadHolidays() -> [Holiday] {
        guard let data = UserDefaults.standard.data(forKey: holidaysKey) else { return [] }
        do {
            let decoder = JSONDecoder()
            let holidays = try decoder.decode([Holiday].self, from: data)
            print("Holidays успешно загружены из кэша")
            return holidays
        } catch {
            print("Ошибка при загрузке данных: \(error.localizedDescription)")
            return []
        }
    }
}
