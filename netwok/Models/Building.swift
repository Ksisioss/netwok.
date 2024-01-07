//
//  Building.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import Foundation

struct Building: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var image1: String
    var image2: String
    var image3: String

    enum CodingKeys: String, CodingKey {
        case id, name, address, latitude, longitude
        case image1 = "image_1"
        case image2 = "image_2"
        case image3 = "image_3"
    }
}

