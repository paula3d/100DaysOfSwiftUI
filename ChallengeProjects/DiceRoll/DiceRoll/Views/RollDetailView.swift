//
//  RollDetailView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 25/02/2023.
//

import SwiftUI

struct RollDetailView: View {
    
    var roll : Roll
    var numberOfDices : Int {
        return roll.rolledDices.count
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(0..<numberOfDices) { index in
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(roll.rolledDices[index].sides)-sided dice")
                                    .font(.headline)
                            }
                            Spacer()
                            Text("\(roll.rolledValues[index])")
                        }
                    }
                } header: {
                    Text("Used dices")
                }
            }
            .navigationTitle("Roll Details")
            .navigationBarHidden(true)
        }
    }
}

struct RollDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RollDetailView(roll: Roll())
    }
}
