//
//  EquipmentRow.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//

import SwiftUI
import AVKit

struct EquipmentRow: View {
    var equipment: Equipment
    @AppStorage("showFavorites") private var showFavoritesOnly = false
    @AppStorage("ipAddress") private var ipAddress = ""
    @AppStorage("port") private var port = ""
    
    var body: some View {
        HStack(spacing: 20) {
            // Equipment Image
            AsyncImage(url: URL(string: ipAddress + ":" + port + "/" + equipment.imageName)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjusted frame size
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 4)
                    )
                    .shadow(radius: 5)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 150, height: 200)
            .cornerRadius(10)
            .shadow(radius: 5)
            
            // Equipment Details
            VStack(alignment: .leading, spacing: 8) {
                Text(equipment.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Text("Year: \(equipment.year)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("Directed By: \(equipment.director)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Favorite Icon
            if equipment.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
        .padding(.vertical, 8)
               .padding(.horizontal, 16)
               .background(Color(.systemGray6)) // Subtle gray background
               .cornerRadius(12)
               .overlay(
                   RoundedRectangle(cornerRadius: 12)
                       .stroke(Color.gray.opacity(0.5), lineWidth: 0.5) // Border
               )
               .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
