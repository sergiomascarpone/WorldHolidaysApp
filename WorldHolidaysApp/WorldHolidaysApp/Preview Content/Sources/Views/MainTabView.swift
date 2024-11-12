//
//  MainTabView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HolidaysListView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("List")
                }
            
            HolidaysCalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}


#Preview {
    MainTabView()
}
