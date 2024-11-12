//
//  SettingsView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedLanguage = Locale.current.language.languageCode?.identifier ?? "en"
    let languages = ["en": "English", "ru": "Russian", "fr": "French", "de": "German", "es": "Spanish", "it": "Italian", "pl": "Polish", "sr": "Serbian"]

    var body: some View {
        Form {
            Section(header: Text("Language")) {
                Picker("Select Language", selection: $selectedLanguage) {
                    ForEach(languages.keys.sorted(), id: \.self) { key in
                        Text(languages[key] ?? key).tag(key)
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}



//#Preview {
//    SettingsView()
//}
