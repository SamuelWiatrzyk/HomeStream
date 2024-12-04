//
//  Users.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-20.
//

import Foundation


class Users: ObservableObject {
    var settingsManager = SettingsManager()
    
    
    
    
    @Published var all = [User]([])
    init(users: [User]) {
        self.all = users
    }

    init() {
        
        guard let url = URL(string: settingsManager.ipAddress + ":" + settingsManager.port + "/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)

        let session = URLSession.shared.dataTask(with: request) { data, response, sessionError in
            guard let data = data else {
                print("Fetch failed: \(sessionError?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                var decoded = try JSONDecoder().decode([User].self, from: data)
                // sort
                decoded.sort { $0.name < $1.name }
                // This is for sorting numerically
                
               // for (i, _) in decoded.enumerated() {
                 //   decoded[i].friends.sort { $0.name < $1.name }
               // }
                DispatchQueue.main.async { [weak self] in
                    self?.all = decoded
                }
            }
            catch let decodingError {
                print("Decoding failed: \(decodingError.localizedDescription)")
            }
        }

        DispatchQueue.global().async {
            session.resume()
        }
    }

    func find(withId: String) -> User? {
        return all.first { $0.id == withId }
    }
}
