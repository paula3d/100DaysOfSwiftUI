//
//  HistoryView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var rolls : Rolls
    
    var body: some View {
        NavigationView {
            List {
                ForEach(rolls.rolls) { roll in
                    NavigationLink {
                        RollDetailView(roll: roll)
                    } label: {
                        Text("Total rolled: \(roll.summedValue)")
                    }
                }
            }
            .navigationTitle("Past rolls")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
