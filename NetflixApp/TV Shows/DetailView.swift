//
//  DetailView.swift
//  NetflixApp
//
//  Created by Samuel Wiatrzyk on 2023-07-20.
//

import SwiftUI


// Linked Episode

struct FriendView: View {
    @ObservedObject var users: Users
    var friend: Friend

    var body: some View {
        if let foundFriend = self.users.find(withId: friend.id) {
            return AnyView(LinkedFriendView(users: users, friend: friend))
        }
        else {
            return AnyView(Text(friend.name))
        }
    }
}

struct LinkedFriendView: View {
    
    @ObservedObject var users: Users
    var friend: Friend

    var body: some View {
        NavigationLink(destination: EpisodeDetail(users: users, friend: friend)) {
            VStack(alignment: HorizontalAlignment.leading) {
                Text(friend.name)
                    .font(.headline)
                HStack {
                    Text("URL:").font(.headline)

                    Text(String(friend.url))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(String(friend.id)).font(.subheadline).foregroundColor(.gray)
                    
                }
                HStack {
                    Text("Episode Information:").font(.headline)
                    Text("").foregroundColor(.gray)
                }
            }
        }
    }
    
}




struct DetailView: View {
    @AppStorage("ipAddress") var ipAddress = ""
    @AppStorage("port") var port = ""
    @ObservedObject var users: Users
    var user: User
 
    var body: some View {
        List {
            
            HStack {
                Spacer()
                AsyncImage(url: URL(string: ipAddress + ":" + port + "/" + user.address)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 300, height: 400)
                Spacer()
            }
            Section(header: Text("TV Show Name")) {
                Text(user.name)
            }
            Section(header: Text("About")) {
                Text(user.about)
            }
            
         
         
                
                
                Section(header: Text("Episodes")) {
                    ForEach(user.friends) { friend in
                        
                        NavigationLink(String(friend.name), destination: LinkedFriendView(users: self.users, friend: friend))
                    }
                }
            
        }
        .navigationBarTitle("\(user.name)", displayMode: .inline)
    }
}


