//
//  CategoryHome.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-25.
//
import SwiftUI

struct CategoryHome: View {
    @EnvironmentObject var modelData: ModelData
    @AppStorage("genreView") var genreView: Bool = false
    @Environment(\.colorScheme) var colorScheme // Detect light/dark mode
    
    var body: some View {
        NavigationView {
            VStack {
                // Header
                HStack {
                    Text("Home")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .white : .primary) // White in dark mode, primary in light mode
                    Spacer()
                }
                .padding()
                
                // Scrollable content
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                            RandomizableCategoryRow(categoryName: key, items: modelData.categories[key]!)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 10) // Add vertical padding for better spacing
                }
            }
            .background(colorScheme == .dark ? Color.black : Color.white) // Black background for dark mode, white for light mode
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(colorScheme == .dark ? Color.white : Color.blue) // Accent color for interactive elements (buttons, highlights)
    }
}

struct RandomizableCategoryRow: View {
    @AppStorage("hapticOn") var hapticOn = true
    let categoryName: String
    @State private var shuffledItems: [Equipment]
    @Environment(\.colorScheme) var colorScheme // Detect light/dark mode
    
    init(categoryName: String, items: [Equipment]) {
        self.categoryName = categoryName
        self._shuffledItems = State(initialValue: items.shuffled())
    }
    
    var body: some View {
        VStack {
            CategoryRow(categoryName: categoryName, items: shuffledItems)
                .padding(.top, 10)
            
            HStack {
                Spacer()
                // Alphabetize button
                Button(action: {
                    if hapticOn {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    shuffledItems.sort { $0.name.lowercased() < $1.name.lowercased() } // Alphabetize items
                }, label: {
                    Text("A-Z")
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding()
                        .background(Circle().fill(colorScheme == .dark ? Color.green : Color.green.opacity(0.7)))
                        .foregroundColor(.white)
                })
                
                Spacer()
                // Shuffle Button
                Button(action: {
                    if hapticOn {
                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                        impactMed.impactOccurred()
                    }
                    shuffledItems.shuffle() // Shuffle items on button tap
                }, label: {
                    Image(systemName: "rectangle.2.swap")
                        .font(.title2)
                        .padding()
                        .background(Circle().fill(colorScheme == .dark ? Color.blue : Color.blue.opacity(0.7))) // Button background color
                        .foregroundColor(.white) // Icon color (always white for visibility)
                })
                
                Spacer()
                
                
            }
            .padding()
        }
        .padding(.horizontal) // Horizontal padding around each category row
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? Color(UIColor.secondarySystemBackground) : Color.white) // Darker background in dark mode, white in light mode
                .shadow(radius: colorScheme == .dark ? 10 : 5) // Slightly softer shadow in light mode
        )
        .padding(.vertical, 5) // Add vertical padding between rows
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoryHome()
                .environmentObject(ModelData())
                .previewDisplayName("Light Mode")
                .environment(\.colorScheme, .light) // Preview in light mode
            
            CategoryHome()
                .environmentObject(ModelData())
                .previewDisplayName("Dark Mode")
                .environment(\.colorScheme, .dark) // Preview in dark mode
        }
    }
}
