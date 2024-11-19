//
//  HolidayImage.swift
//  WorldHolidaysApp
//
//  Created by Sergio Mascarpone on 19.11.24.
//

import SwiftUI

struct HolidayImage: View {
    let imageName: String

    var body: some View {
        if let image = UIImage(named: imageName) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(height: 120)
                .cornerRadius(8)
                .clipped()
        } else {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.3))
                .frame(height: 120)
                .overlay(
                    Text("No Image Available")
                        .foregroundColor(.gray)
                        .font(.caption)
                )
        }
    }
}

