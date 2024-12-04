//
//  Friends.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-23.
//

import Foundation


public class UserFetcher: ObservableObject {

    @Published var friends = [Friend]()
    
    init(){
        load()
    }
    
    func load() {
        let url = URL(string: "http://10.0.0.174:8888/friendface.json")!

    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = data {
                    let decodedLists = try JSONDecoder().decode([Friend].self, from: d)
                    DispatchQueue.main.async {
                        self.friends = decodedLists
                    }
                }else {
                    print("No Data")
                }
            } catch {
                print ("Error")
            }
            
        }.resume()
       
    }
}
