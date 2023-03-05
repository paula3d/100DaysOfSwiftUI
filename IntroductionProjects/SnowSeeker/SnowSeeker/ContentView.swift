//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Paulina Dąbrowska on 26/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    @StateObject var favorites = Favorites()
    
    enum SortOrder {
        case unsorted, byName, byCountry
    }
    @State var sortOrder = SortOrder.unsorted
    var sortedResorts : [Resort] {
        switch sortOrder {
        case .unsorted:
            return filteredResorts
        case .byName:
            return filteredResorts.sorted {
                $0.name < $1.name
            }
        case .byCountry:
            return filteredResorts.sorted {
                $0.country < $1.country
            }
        }
    }
    @State var showingSortingOptions = false
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 5)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                        )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
//            .phoneOnlyStackNavigationView()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSortingOptions = true
                    } label: {
                        Text("Sort")
                    }
                }
            }
            .confirmationDialog("Change sorting", isPresented: $showingSortingOptions) {
                Button {
                    sortOrder = .unsorted
                } label: {
                    Text("Default")
                }
                .disabled(sortOrder == .unsorted)
                
                Button {
                    sortOrder = .byName
                } label: {
                    Text("By name")
                }
                .disabled(sortOrder == .byName)
                
                Button {
                    sortOrder = .byCountry
                } label: {
                    Text("By country")
                }
                .disabled(sortOrder == .byCountry)
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
