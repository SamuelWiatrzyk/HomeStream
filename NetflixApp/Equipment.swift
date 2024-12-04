//
//  Equipment.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//


import Foundation
import SwiftUI



struct Equipment: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var image: Image {
        Image(imageName)
    }
    var videourl : String
    var director: String
    var synopsis: String
    var year: String
    var isFavorite: Bool
    var isFeatured: Bool
    
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case thriller = "Thriller"
        case horror = "Horror"
        case comedy = "Comedy"
        case documentary = "Documentary"
        case action = "Action"
        case romance = "Romance"
        case animated = "Animated"
        case scifi = "Sci-Fi"
        case fantasy = "Fantasy"
        case drama = "Drama"
        case crime = "Crime"
        case newlyAdded = "Newly Added"
        
        
    }
}
