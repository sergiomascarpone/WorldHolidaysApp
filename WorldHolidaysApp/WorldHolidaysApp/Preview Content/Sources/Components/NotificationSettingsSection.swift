//
//  NotificationSettingsSection.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 2.12.24.
//

import SwiftUI

struct NotificationSettingsSection: View {
    @Binding var isNotificationsEnabled: Bool

    var body: some View {
        Section(header: Text(LocalizationManager.shared.localizedString(forKey: "Notifications"))) {
            Toggle(
                LocalizationManager.shared.localizedString(forKey: "Enable Holiday Notifications"),
                isOn: $isNotificationsEnabled
            )
            .onChange(of: isNotificationsEnabled) { newValue in
                UserDefaults.standard.set(newValue, forKey: "isNotificationsEnabled")
                if newValue {
                    Task {
                        await NotificationManager.shared.scheduleNotificationsForToday()
                    }
                } else {
                    NotificationManager.shared.cancelAllNotifications()
                }
            }
        }
    }
}

extension NotificationManager {
    func scheduleNotificationsForToday() async {
        let holidaysService = HolidaysService()
        let year = Calendar.current.component(.year, from: Date())
        let countryCode = Locale.current.region?.identifier ?? "US"

        let holidays = await holidaysService.fetchHolidays(for: year, country: countryCode)
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        if let todayHoliday = holidays.first(where: { holiday in
            let holidayDate = calendar.startOfDay(for: holiday.date)
            return holidayDate == today
        }) {
            scheduleTodayHolidayNotification(for: todayHoliday)
        }
    }
}
