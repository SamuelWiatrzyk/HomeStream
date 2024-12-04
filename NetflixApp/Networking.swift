//
//  Networking.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2024-01-20.
//

import SwiftUI

class SettingsManager: ObservableObject {
    @AppStorage("ipAddress") var ipAddress = ""
    @AppStorage("port") var port = ""
}

struct Networking: View {
    var settingsManager = SettingsManager()
    @AppStorage("ipAddress") var ipAddress = ""
    @AppStorage("port") var port = ""
    @AppStorage("darkmode") var darkMode = false
    @AppStorage("hapticOn") var hapticOn = true
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    // Section 1 with image
                    Section(header: HStack {
                        Image(systemName: "network")
                            .foregroundColor(.blue)
                        Text("Networking")
                            .font(.headline)
                    }) {
                        HStack {
                            Text("IP Address: ")
                            TextField("Ip Address / URL", text: $ipAddress)
                        }
                        
                        HStack {
                            Text("Port: ")
                            TextField("eg. 8888", text: $port)
                                .keyboardType(.decimalPad)
                        }
                    }
                    
                    // Section 2 with image
                    Section(header: HStack {
                        Image(systemName: "accessibility")
                            .foregroundColor(.green)
                        Text("Accessibility")
                            .font(.headline)
                    }) {
                        Toggle(isOn: $darkMode) {
                            HStack {
                                if darkMode {
                                    Image(systemName: "lightbulb.slash")
                                } else {
                                    Image(systemName: "lightbulb")
                                }
                                Text("Toggle Light and Dark Mode")
                            }
                        }
                        
                        Toggle(isOn: $hapticOn) {
                            HStack {
                                if hapticOn == true {
                                    Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                                } else {
                                    Image(systemName: "iphone.gen3")
                                }
                                Text("Toggle Haptics")
                            }
                        }
                    }

                }
                .navigationTitle("Settings")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
