//
//  SideBySideView.swift
//  SnowSeeker
//
//  Created by Paulina Dąbrowska on 26/02/2023.
//

import SwiftUI

struct SideBySideView: View {
    var body: some View {
        
        NavigationView {
            NavigationLink {
                Text("New secondary")
            } label: {
                Text("Hello, World!")
            }
            .navigationTitle("Primary")

            Text("Secondary")
        }
    }
}

struct SideBySideView_Previews: PreviewProvider {
    static var previews: some View {
        SideBySideView()
    }
}
