//
//  MainTabView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

//struct MainTabView: View {
//    var body: some View {
//        TabView {
//            HolidaysListView()
//                .tabItem {
//                    Image(systemName: "list.bullet")
//                    Text("List")
//                }
//            HolidaysCalendarView()
//                .tabItem {
//                    Image(systemName: "calendar")
//                    Text("Calendar")
//                }
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Settings")
//                }
//        }
//    }
//}

struct MainTabView: View {
    @State private var selectedTab: Tab = .list
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selectedTab {
                case .list:
                    HolidaysListView()
                case .calendar:
                    HolidaysCalendarView()
                case .settings:
                    SettingsView()
                }
            }
            CustomTabBar(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

enum Tab: String, CaseIterable {
    case list = "List"
    case calendar = "Calendar"
    case settings = "Settings"
    
    var icon: String {
        switch self {
        case .list:
            return "list.bullet"
        case .calendar:
            return "calendar"
        case .settings:
            return "gear"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                VStack{
                    Image(systemName: tab.icon)
                        .font(.system(size: 24))
                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                    Text(tab.rawValue)
                        .font(.caption)
                        .foregroundColor(selectedTab == tab ? .blue : .gray)
                }
                .onTapGesture {
                    withAnimation {
                        selectedTab = tab
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .background(Color(.systemBackground).shadow(radius: 4))
    }
}
#Preview {
    MainTabView()
}
