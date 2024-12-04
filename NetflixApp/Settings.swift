//
//  Settings.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//

import SwiftUI

struct Settings: View {
    
    @AppStorage("directorSearch") private var directorSearch = false
    
    
    var body: some View {
        Toggle(isOn: $directorSearch) {
            HStack {
                Text("Toggle Director Search").padding()
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
