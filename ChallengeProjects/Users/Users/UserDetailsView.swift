//
//  UserDetailsView.swift
//  Users
//
//  Created by Paulina Dąbrowska on 29/01/2023.
//

import SwiftUI

struct UserDetailsView: View {
    
    let user : User
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Name:")
                        Spacer()
                        Text(user.name)
                    }
                    HStack {
                        Text("Activity:")
                        Spacer()
                        Text(user.isActive ? "Is active" : "Is not active")
                    }
                    HStack {
                        Text("Email:")
                        Spacer()
                        Text(user.email)
                    }
                    HStack {
                        Text("Registered date:")
                        Spacer()
                        Text(user.registered.formatted(.dateTime.day().month().year()))
                    }
                    HStack {
                        Text("Company:")
                        Spacer()
                        Text(user.company)
                    }
                    HStack {
                        Text("Age:")
                        Spacer()
                        Text(String(user.age))
                    }
                }
                .padding(.horizontal)
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Friends")
                        .font(.headline)
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
                
                Spacer()
            }
            
            .foregroundColor(user.isActive ? .black : .gray)
            .navigationTitle(user.name)
        }
    }
}
/*
 struct UserDetailsView_Previews: PreviewProvider {
 static var previews: some View {
 UserDetailsView()
 }
 }
 */
