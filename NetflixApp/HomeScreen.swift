//
//  HomeScreen.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2024-02-24.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var modelData: ModelData
    @State var data: [Equipment]? // Replace with your actual data type
    var equipment : Equipment
    var body: some View {
        NavigationView {
            VStack {
                // Trending Now Section
                HStack {
                    Text("Trending Now")
                        .font(.title2)
                        .bold()
                    Spacer()
                }
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(modelData.categories.keys.sorted(), id: \.self) { movie in // Show only first 5 items
                            MoviePosterView(equipment: equipment)
                                .frame(width: 150)
                        }
                    }
                }
                .padding(.bottom)

                // Category Sections
                ForEach(modelData.categories.keys.sorted(), id: \.self) { category in
                    HStack {
                        Text(category)
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(data?.filter { $0.category == category } ?? []) { movie in
                                MoviePosterView(movie: movie)
                                    .frame(width: 150)
                            }
                        }
                    }
                    .padding(.bottom)
                }
            }
            .navigationTitle("My Streaming App")
        }
        .onAppear {
            // Load your data from an API or local storage here
        }
    }
}

struct MoviePosterView: View {

    @EnvironmentObject var modelData: ModelData
    var equipment : Equipment
    var body: some View {
        VStack {
            Image(equipment.imageName) // Replace with actual image loading
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 200)
            Text(equipment.name)
                .font(.caption)
                .lineLimit(2)
        }
    }
}

// Helper extension to find unique categories
//extension Array where Element: Movie {
  //  func uniqueCategories() -> [String] {
    //    return self.reduce(into: Set<String>()) { result, element in
      //      result.insert(element.category)
   //     }
     //   .sorted()
   // }
//}

