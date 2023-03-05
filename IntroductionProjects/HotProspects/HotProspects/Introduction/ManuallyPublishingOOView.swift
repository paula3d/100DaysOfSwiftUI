//
//  ManuallyPublishingOOView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 14/02/2023.
//

import SwiftUI

struct ManuallyPublishingOOView: View {
    
    @StateObject var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

struct ManuallyPublishingOOView_Previews: PreviewProvider {
    static var previews: some View {
        ManuallyPublishingOOView()
    }
}

@MainActor class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            objectWillChange.send()
            // additional functionality that will happen as the value updates
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
