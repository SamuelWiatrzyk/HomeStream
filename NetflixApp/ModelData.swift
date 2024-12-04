//
//  ModelData.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//

import Foundation
import Combine




final class ModelData: ObservableObject {
    @Published var equipment: [Equipment] = load("equipmentData.json")
    
   
    
    var features: [Equipment] {
        equipment.filter { $0.isFeatured }
    }
    
    var categories: [String: [Equipment]] {
        Dictionary (
            grouping: equipment,
            by: { $0.category.rawValue }
        )
    }
    
}





func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    

    do {

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
        
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}














