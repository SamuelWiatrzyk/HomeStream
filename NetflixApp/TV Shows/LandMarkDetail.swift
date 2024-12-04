//
//  LandmarkDetail.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-23.
//

import SwiftUI
import AVKit

struct LandmarkDetail: View {
    var landmark: Landmark

    var body: some View {

           
       
       
                VideoPlayer(player: AVPlayer(url: URL(string: landmark.url)!)) {
                    VStack {
                        HStack {
                            Text("Overlay").foregroundColor(.white)
                        }
                    }
                }
                
                .navigationTitle(landmark.name)
                .navigationBarTitleDisplayMode(.inline)
                .onAppear() {
                    AVPlayer(url: URL(string: landmark.url)!).play()
                }
                .onDisappear {
                    AVPlayer(url: URL(string: landmark.url)!).pause()
                }

               
              
            
            

    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarks[0])
    }
}

