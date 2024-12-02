//
//  LanguageSelectionSection.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 2.12.24.
//

import SwiftUI

struct LanguageSelectionSection: View {
    @Binding var selectedLanguage: String

    let languages = [
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
        Section(header: Text(LocalizationManager.shared.localizedString(forKey: "Select Language"))) {
            Picker(LocalizationManager.shared.localizedString(forKey: "Language"), selection: $selectedLanguage) {
                ForEach(languages, id: \.0) { code, name in
                    Text(name).tag(code)
                }
            }
            .onChange(of: selectedLanguage) { newLanguage in
                LocalizationManager.shared.setLanguage(newLanguage)
            }
        }
    }
}
