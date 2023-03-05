//
//  OptionalSheetAlertView.swift
//  SnowSeeker
//
//  Created by Paulina Dąbrowska on 26/02/2023.
//

import SwiftUI

struct OptionalSheetAlertView: View {
    
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
            .alert("Welcome", isPresented: $isShowingUser) { }
    }
}

struct OptionalSheetAlertView_Previews: PreviewProvider {
    static var previews: some View {
        OptionalSheetAlertView()
    }
}

struct User: Identifiable {
    var id = "Taylor Swift"
}
