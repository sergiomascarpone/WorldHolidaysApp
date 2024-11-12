//
//  FiltersView.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 12.11.24.
//

import SwiftUI

struct FiltersView: View {
    @State private var selectedCountry = Locale.current.region?.identifier ?? "US"
    @State private var holidayTypes = ["All", "National", "Religious", "Seasonal"]
    @State private var selectedType = "All"

    let countries = ["US": "United States", "DE": "Germany", "FR": "France", "RU": "Russia", "BY:": "Belarus"]

    var body: some View {
        Form {
            Section(header: Text("Country")) {
                Picker("Select Country", selection: $selectedCountry) {
                    ForEach(countries.keys.sorted(), id: \.self) { key in
                        Text(countries[key] ?? key).tag(key)
                    }
                }
            }
            
            Section(header: Text("Holiday Type")) {
                Picker("Select Type", selection: $selectedType) {
                    ForEach(holidayTypes, id: \.self) { type in
                        Text(type)
                    }
                }
            }
        }
        .navigationTitle("Filters")
    }
}

