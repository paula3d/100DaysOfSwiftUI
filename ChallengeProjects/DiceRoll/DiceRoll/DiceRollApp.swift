//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

@main
struct DiceRollApp: App {
    
    @StateObject var dices = Dices()
    @StateObject var rolls = Rolls()
    @StateObject var usersDices = UsersDices()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dices)
                .environmentObject(rolls)
                .environmentObject(usersDices)
        }
    }
}
