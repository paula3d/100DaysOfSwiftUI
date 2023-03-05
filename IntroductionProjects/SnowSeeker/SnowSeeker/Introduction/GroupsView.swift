//
//  GroupsView.swift
//  SnowSeeker
//
//  Created by Paulina Dąbrowska on 27/02/2023.
//

import SwiftUI

struct GroupsView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            VStack(content: UserView.init)
        } else {
            HStack(content: UserView.init)
        }
    }
    
    
//    @State private var layoutVertically = false
//
//    var body: some View {
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }
//    }
}

struct GroupsView_Previews: PreviewProvider {
    static var previews: some View {
        GroupsView()
    }
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}
