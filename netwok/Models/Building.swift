//
//  Building.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import Foundation

struct Building : Codable, Hashable, Identifiable{
    var id: String
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
}