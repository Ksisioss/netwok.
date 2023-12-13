//
//  User.swift
//  netwok
//
//  Created by lebreuil thibault on 13/12/2023.
//

import Foundation

struct User: Codable, Hashable {
    var lastame: String
    var firstname: String
    var company: String
    var job_title: String
    var email: String
    var building: String
    var inside: Bool
    var avatar: URL?
}
