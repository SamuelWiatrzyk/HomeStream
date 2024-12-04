//
//  CategoryItem.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-25.
//

import SwiftUI

struct CategoryItem: View {
    var equipment: Equipment
    @AppStorage("ipAddress") var ipAddress = ""
    @AppStorage("port") var port = ""
    @AppStorage("darkmode") var darkMode = true
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: ipAddress + ":" + port + "/" + equipment.imageName)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Adjusted frame size
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(darkMode ? Color.white : Color.gray, lineWidth: 4)
                    )
                    .shadow(radius: 5)
                
            } 
        placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                                    .stroke(darkMode ? Color.white : Color.gray, lineWidth: 4)            )
            .shadow(radius: 5)
            
            Text(equipment.name)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top, 5)
        } 
    }
}



struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(equipment: ModelData().equipment[0])
    }
}
