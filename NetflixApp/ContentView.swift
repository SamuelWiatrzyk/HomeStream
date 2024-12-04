//
//  ContentView.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//



import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var searchingFor = ""
    @AppStorage("directorSearch") private var directorSearch = false
    
    @AppStorage("inputUnit") var inputUnit = 3
    @State private var inputUnits = ["Search Name", "Search Director", "Search Year"]

    @AppStorage("showFavorites") private var showFavoritesOnly = false
    @AppStorage("SearchName") private var searchName = false
    @AppStorage("SearchDirector") private var searchDirector = false
    @AppStorage("SearchYear") private var searchYear = false
    
    // Haptic feedback generator
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var filteredEquipment: [Equipment] {
        if searchingFor == "" && showFavoritesOnly == false {
            return modelData.equipment.sorted {$0.name < $1.name}
        }
        
        if  showFavoritesOnly == true && searchingFor == "" {
            return modelData.equipment.filter { equipment in
                (!showFavoritesOnly || equipment.isFavorite)
            }
        }
        
        if inputUnit == 0 {
            return modelData.equipment.filter { $0.name.localizedCaseInsensitiveContains(searchingFor) }
        }
        
        if inputUnit == 1 {
            return modelData.equipment.filter { $0.director.localizedCaseInsensitiveContains(searchingFor) }
        }
        
        if inputUnit == 2 {
            return modelData.equipment.filter { $0.year.localizedCaseInsensitiveContains(searchingFor) }
        }
        
        else {
            return modelData.equipment
        }
    }
    
    @AppStorage("genreView") var genreView: Bool = false
    @AppStorage("HopSheet") var presentSheet = false
    @AppStorage("darkmode") var darkMode = true
    @AppStorage("hapticOn") var hapticOn = true
    
    var body: some View {
        TabView {
            // Category Home Tab
            CategoryHome().tabItem {
                Label("Home", systemImage: "house")
            }
            
            // Movies Tab
            NavigationView {
                List(filteredEquipment) { equipment in
                    NavigationLink {
                        EquipmentDetail(equipment: equipment)
                            // Trigger haptic feedback when navigating
                            .onAppear {
                                if hapticOn {
                                    feedbackGenerator.prepare() // Prepare for haptic feedback
                                    feedbackGenerator.impactOccurred() // Trigger haptic feedback
                                }
                            }
                    } label: {
                        EquipmentRow(equipment: equipment)
                    }
                }
                .searchable(text: $searchingFor, prompt: Text("Search"))
                .navigationBarItems(trailing: Button("Filters") {
                    if hapticOn {
                        feedbackGenerator.prepare() // Prepare for haptic feedback
                        feedbackGenerator.impactOccurred() // Trigger haptic feedback
                    }
                    presentSheet = true
                })
                .navigationTitle("Movies")
                .sheet(isPresented: $presentSheet) {
                    FilterSheet()
                }
            }
            .accentColor(.white)
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Label("Movies", systemImage: "film")
            }
            
            // TV Shows Tab
            TVShows().tabItem {
                Label("TV Shows", systemImage: "tv")
            }
            
            // Settings Tab
            Networking().tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
        .environment(\.colorScheme, darkMode ? .dark : .light)
    }
}

