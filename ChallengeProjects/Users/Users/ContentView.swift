//
//  ContentView.swift
//  Users
//
//  Created by Paulina Dąbrowska on 29/01/2023.
//

// CHALLENGE - DAY 60

import SwiftUI

struct ContentView: View {
    
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var users = [User]()
    
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var loadingOnlineDataFailed = false
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserDetailsView(user: user)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text(user.email)
                                .font(.subheadline)
                        }
                        .foregroundColor(user.isActive ? .black : .gray)
                        
                    }
                }
                
            }
            .navigationTitle("Users")
            .task {
                await loadData()
            }
        }
        
    }
    func loadData() async {
        
        if !cachedUsers.isEmpty {
            for user in cachedUsers {
                var friends = [User.Friend]()
                
                if let cachedFriends = user.friends {
                    for friend in cachedFriends {
                        friends.append(User.Friend(id: (friend as! CachedFriend).id ?? "Unknown id", name: (friend as! CachedFriend).name ?? "Unknown name"))
                    }
                    
                    users.append(User(id: user.id ?? "Unknown id", isActive: user.isActive , name: user.name ?? "Unknown name", age: Int(user.age), company: user.company ?? "Unknown company", email: user.email ?? "Unknown email", address: user.address ?? "Unknown address", about: user.about ?? "No info", registered: user.registered ?? Date.now, tags: user.tags ?? [String](), friends: friends))
                }
            }
        }
        
        
        guard users.isEmpty else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            loadingOnlineDataFailed = true
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // more code to come
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
                
                await MainActor.run {
                    // save to core data
                    saveCoreData()
                }
            } else {
                loadingOnlineDataFailed = true
            }
        } catch {
            loadingOnlineDataFailed = true
            print("Invalid data")
        }
    }
    
    func saveCoreData(){
        
        for user in users {
            let newUser = CachedUser(context: moc)
            newUser.id = user.id
            newUser.name = user.name
            newUser.age = Int16(user.age)
            newUser.address = user.address
            newUser.registered = user.registered
            newUser.about = user.about
            newUser.tags = user.tags
            newUser.email = user.email
            newUser.company = user.company
            newUser.isActive = user.isActive
            
            var newFriends = [CachedFriend]()
            for friend in user.friends {
                let newFriend = CachedFriend(context: moc)
                newFriend.id = friend.id
                newFriend.name = friend.name
                newFriends.append(newFriend)
            }
        }
        
        try? moc.save()
    }
}
/*
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }*/
