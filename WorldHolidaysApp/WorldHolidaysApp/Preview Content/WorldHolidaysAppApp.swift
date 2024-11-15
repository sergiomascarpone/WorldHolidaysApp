//
//  WorldHolidaysAppApp.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

@main
struct WorldHolidaysApp: App {
    
    init() {
            NotificationManager.shared.requestAuthorization()
        }
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
    }
}
