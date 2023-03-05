//
//  BackgroundView.swift
//  Flashzilla
//
//  Created by Paulina Dąbrowska on 19/02/2023.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
