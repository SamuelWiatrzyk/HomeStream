//  SynopsisView.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-23.
//

import SwiftUI

struct SynopsisView: View {
    @AppStorage("ipAddress") private var ipAddress = ""
    @AppStorage("port") private var port = ""
    @AppStorage("showFavorites") private var showFavoritesOnly = false
    @Binding var isSet: Bool
    @AppStorage("darkmode") var darkMode = true
    var equipment: Equipment
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Movie title
            
                
                HStack {
                    VStack {
                        Text(equipment.name)
                            .font(.title)
                            .fontWeight(.bold)
                        // Year
                        Text("(\(equipment.year))")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    // Favorite button
                    Button(action: {
                        isSet.toggle()
                    }) {
                        Image(systemName: isSet ? "star.fill" : "star")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                            .foregroundColor(isSet ? .yellow : .gray)
                    }
                }
                
              
                
                Divider()
                
                // Movie image
                AsyncImage(url: URL(string: ipAddress + ":" + port + "/" + equipment.imageName)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        
                } placeholder: {
                    ProgressView()
                }
                .frame(maxHeight: 500)
                
                // Director
                Text("Directed By: \(equipment.director)")
                    .font(.headline)
                
                Divider()
                
                // Call for synopsis information contained in the JSON array
                Text("Synopsis")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(equipment.synopsis)
                    .font(.body)
            }.environment(\.colorScheme, darkMode ? .dark : .light)
            .padding()
        }.environment(\.colorScheme, darkMode ? .dark : .light)
       
    }
}

