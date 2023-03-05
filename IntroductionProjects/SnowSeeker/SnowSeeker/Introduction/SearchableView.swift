//
//  SearchableView.swift
//  SnowSeeker
//
//  Created by Paulina Dąbrowska on 27/02/2023.
//

import SwiftUI

struct SearchableView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    
    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
            // or contains(searchText) <- its worse
        }
    }
}

struct SearchableView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableView()
    }
}

struct EasySearchableView : View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            Text("Searching for \(searchText)")
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
        }
    }
}
