//
//  SwiftUIView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 13/02/2023.
//

import SwiftUI

struct EnviromentObjectView: View {
    
    @StateObject var user = User()
    
    var body: some View {
        VStack {
            EditView()
            DisplayView()
        }
        .environmentObject(user)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        EnviromentObjectView()
    }
}

@MainActor class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User
    
    var body: some View {
        Text(user.name)
    }
}
