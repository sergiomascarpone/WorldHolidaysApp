//
//  SettingsView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedLanguage: String = LocalizationManager.shared.currentLanguage
    
    var languages = [
        ("en", "English"),
        ("ru", "Русский"),
        ("fr", "Français"),
        ("de", "Deutsch"),
        ("es", "Español"),
        ("it", "Italiano"),
        ("pl", "Polski"),
        ("sr", "Српски")
    ]
    
    var body: some View {
        Form {
            Section(header: Text(LocalizationManager.shared.localizedString(forKey: "Select Language"))) {
                Picker("Language", selection: $selectedLanguage) {
                    ForEach(languages, id: \.0) { code, name in
                        Text(name).tag(code)
                    }
                }
                .onChange(of: selectedLanguage) { newLanguage in
                    LocalizationManager.shared.setLanguage(newLanguage)
                }
//                .onReceive(NotificationCenter.default.publisher(for: .languageDidChange)) { _ in
//                    UIApplication.shared.windows.first?.rootViewController =
//                        UIHostingController(rootView: ContentView())
//                }
            }
        }
        .navigationTitle(LocalizationManager.shared.localizedString(forKey: "Settings"))
        .onAppear {
            selectedLanguage = LocalizationManager.shared.currentLanguage
        }
    }
}

//#Preview {
//    SettingsView()
//}
