//
//  FilterSheet.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-20.
//

import SwiftUI

struct FilterSheet: View {
    
    @AppStorage("directorSearch") private var directorSearch = false
    
    @State private var inputUnits = ["Search Name", "Search Director", "Search Year"]
    @AppStorage("inputUnit") var inputUnit = 3
    

    
    @AppStorage("showFavorites") private var showFavoritesOnly = false
    @AppStorage("filterYear") private var filterYear = false
    
    
    @AppStorage("SearchName") private var searchName = false
    @AppStorage("SearchDirector") private var searchDirector = false
    @AppStorage("SearchYear") private var searchYear = false
    

    @AppStorage("genreView") var genreView: Bool = false

    var body: some View {
        

        
        Form {
            
            
            
            HStack {

                
                Picker("List Filter Settings", selection: $inputUnit) {
                    ForEach(0..<inputUnits.count) {
                        Text("\(self.inputUnits[$0])").padding()
                    }
                }.pickerStyle(.wheel)
                
            }.padding()
 
            
            HStack {
                
                Toggle(isOn: $showFavoritesOnly) {
                    HStack {
                        Text("Filter For Favorites Only")
                    }
                }

                
                
            }.padding()
            
            
            HStack {
                
            

                
                
            }.padding()



            
            

            
        .navigationTitle("Filter Settings")
        }.navigationTitle("Filter Settings")
       
    }
}

struct FilterSheet_Previews: PreviewProvider {
    static var previews: some View {
        FilterSheet()
    }
}
