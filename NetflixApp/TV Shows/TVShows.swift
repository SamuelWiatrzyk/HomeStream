//
//  TVShows.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-19.
//
import SwiftUI

struct TVShows: View {
    @ObservedObject var users = Users()
    @State var searchingFor = ""
    @AppStorage("ipAddress") var ipAddress = ""
    @AppStorage("port") var port = ""
    @AppStorage("hapticOn") var hapticOn = true
    
    // Haptic feedback generator
    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .soft)

    var body: some View {
        NavigationView {
            List(filteredTV) { user in
                NavigationLink {
                    DetailView(users: self.users, user: user)
                        // Trigger haptic feedback when navigating
                        .onAppear {
                            if hapticOn {
                                feedbackGenerator.prepare() // Prepare for haptic feedback
                                feedbackGenerator.impactOccurred() // Trigger haptic feedback
                            }
                        }
                } label: {
                    HStack {
                        AsyncImage(url: URL(string: ipAddress + ":" + port + "/" + user.address)) { image in
                            image.resizable()
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
                        
                        Text(user.name)
                            .font(.headline)
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
            .navigationTitle("TV Shows")
            .searchable(text: $searchingFor, prompt: Text("Search"))
        }
        .accentColor(.white)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    var filteredTV: [User] {
        if searchingFor.isEmpty {
            return users.all
        } else {
            return users.all.filter { $0.name.localizedCaseInsensitiveContains(searchingFor) }
        }
    }
}

