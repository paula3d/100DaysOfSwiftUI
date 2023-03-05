//
//  TabViewView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 13/02/2023.
//

import SwiftUI

struct TabViewView: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .onAppear {
                    selectedTab = "One"
                }
            
            Text("Tab 2")
                .tabItem {
                    Image(systemName: "circle")
                    Text("Two")
                }
                .tag("Two")
        }
    }
}

struct TabViewView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewView()
    }
}
