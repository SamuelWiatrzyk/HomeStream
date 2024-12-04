//
//  User.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-20.
//

import Foundation

struct User: Codable, Identifiable {
    var id: String
    var name: String
    var age: Int
    var about: String
    var company: String
    var email: String
    var address: String
    var friends: [Friend]
}

