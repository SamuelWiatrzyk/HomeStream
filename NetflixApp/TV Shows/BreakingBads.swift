//
//  BreakingBads.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-23.
//

import Foundation

class BreakingBads: ObservableObject {
    
    @Published var all = [BreakingBad]([])
 

    init(users: [BreakingBad]) {
        self.all = breakingbad
    }

    init() {
        guard let url = URL(string: "http://10.0.0.174:8888/BreakingBad.json") else {
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
                var decoded = try JSONDecoder().decode([BreakingBad].self, from: data)
                // sort
                decoded.sort { $0.name < $1.name }
               
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

    func find(withId: String) -> BreakingBad? {
        return all.first { $0.id == withId }
    }
}
