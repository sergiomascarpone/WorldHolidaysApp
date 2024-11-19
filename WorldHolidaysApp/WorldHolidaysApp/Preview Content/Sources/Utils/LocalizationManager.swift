//
//  LocalizationManager.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import Foundation

class LocalizationManager {
    static let shared = LocalizationManager()
    private init() {}
    
    var currentLanguage: String {
        get {
            UserDefaults.standard.string(forKey: "selectedLanguage") ?? Locale.current.language.languageCode?.identifier ?? "en"
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "selectedLanguage")
        }
    }
    
    func localizedString(forKey key: String) -> String {
        let languageCode = currentLanguage
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, tableName: nil, bundle: bundle, value: "", comment: "")
    }
    
    func setLanguage(_ language: String) {
        currentLanguage = language
        NotificationCenter.default.post(name: .languageDidChange, object: nil)
    }
}

extension Notification.Name {
    static let languageDidChange = Notification.Name("languageDidChange")
}
