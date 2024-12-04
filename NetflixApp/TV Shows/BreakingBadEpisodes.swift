//
//  BreakingBadEpisodes.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-21.
//

import SwiftUI

struct BreakingBadEpisodes: View {
    
    var breakingbad : Equipm
    
    var body: some View {
        NavigationView {
            List {
                ForEach(breakingbad.all) { user in
                    NavigationLink(destination: DetailView(users: self.users, user: user)) {
                        VStack(alignment: HorizontalAlignment.leading) {
                            
                            HStack {
                            
                            AsyncImage(url: URL(string: user.address)) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 150, height: 200)
                            
                            
                            Text(user.name)
                                .font(.headline)

                            }
                        }
                    }
                }
            }.navigationTitle("TV Shows")
        }
    }
}

struct BreakingBadEpisodes_Previews: PreviewProvider {
    static var previews: some View {
        BreakingBadEpisodes()
    }
}
