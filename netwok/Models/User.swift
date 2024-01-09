//
//  User.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    var id: Int
    var firstname: String
    var lastname: String
    var company: String
    var job_title: String
    var email: String
    var restaurant_name: String
    var is_enter: Bool
    var avatar_url: String
    var restaurantId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, firstname, lastname, company, job_title, email, restaurant_name, is_enter, avatar_url
        case restaurantId = "restaurantId"
    }
}

