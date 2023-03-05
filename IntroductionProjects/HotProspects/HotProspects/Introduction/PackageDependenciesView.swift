//
//  PackageDependenciesView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 15/02/2023.
//

import SwiftUI
import SamplePackage

struct PackageDependenciesView: View {
    
    let possibleNumbers = Array(1...60)
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
    
    var body: some View {
        Text(results)
    }
}

struct PackageDependenciesView_Previews: PreviewProvider {
    static var previews: some View {
        PackageDependenciesView()
    }
}
