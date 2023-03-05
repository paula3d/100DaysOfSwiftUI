//
//  ContentView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            HistoryView()
                .tag(1)
                .tabItem {
                    Label("History", systemImage: "book")
                }
            RollView()
                .tag(2)
                .tabItem {
                    Label("Roll", systemImage: "dice")
                }
            SettingsView()
                .tag(3)
                .tabItem {
                    Label("Settings", systemImage: "pencil")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
