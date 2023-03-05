//
//  AddDiceView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 25/02/2023.
//

import SwiftUI

struct AddDiceView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var dices : Dices
    @EnvironmentObject var usersDices : UsersDices
    
    var possibleDices : [Int] {
        return dices.dices.map { $0.sides }
    }
    
    @State var sides = 6
    @State var number = 1
    @State var input = "1"
    
    @State var showingError = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Sides", selection: $sides) {
                        ForEach(possibleDices, id: \.self) { number in
                            Text("\(number)")
                        }
                    }
                } header: {
                    Text("Pick the size of the dice")
                }
                
                Section {
                    TextField("\(number)", text: $input)
                        .keyboardType(.decimalPad)
                        .onChange(of: input) { input in
                            if let insertedNumber = Int(input) {
                                
                                if insertedNumber + usersDices.dices.count > 10 {
                                    showingError = true
                                } else {
                                    showingError = false
                                    number = insertedNumber
                                }
                                
                            } else {
                                print("Inserted value is not an integer")
                            }
                        }
                } header: {
                    Text("Insert the number of dices to add")
                } footer: {
                    Text("You cannot have more than 10 dices in use")
                        .foregroundColor(.red)
                        .opacity(showingError ? 1 : 0)
                }
            }
            
            .navigationTitle("Add dice")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addDice()
                        dismiss()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    func addDice() {
        let newDice = Dice(sides: sides)
        for _ in 0..<number {
            usersDices.add(newDice)
        }
    }
}

struct AddDiceView_Previews: PreviewProvider {
    static var previews: some View {
        AddDiceView()
    }
}
