//
//  CircleImage.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//

import SwiftUI

struct CircleImage: View {
    var image: Image

    var body: some View {
        image
            .clipShape(Rectangle())
            .overlay {
                Rectangle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("TheWolfOfWallStreet"))
    }
}
