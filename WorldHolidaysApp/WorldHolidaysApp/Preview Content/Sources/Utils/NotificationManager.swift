//
//  NotificationManager.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 15.11.24.
//

import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Разрешение на уведомления получено.")
            } else {
                print("Разрешение на уведомления отклонено.")
            }
        }
    }
}

extension NotificationManager {
    func scheduleTodayHolidayNotification(for holiday: Holiday) {
        let content = UNMutableNotificationContent()
        content.title = "Сегодня праздник!"
        content.body = "Не пропустите: \(holiday.name)"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9  // Время отправки уведомления
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "TodayHolidayNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка отправки уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func cancelAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
}

