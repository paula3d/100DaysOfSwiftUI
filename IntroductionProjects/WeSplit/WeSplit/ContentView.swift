//
//  ContentView.swift
//  WeSplit
//
//  Created by Paulina Dąbrowska on 06/01/2023.
//

import SwiftUI

struct ContentView: View {

    @State private var checkAmount : Double = 0.0
    @State private var numberOfPeople : Int = 2
    @State private var tipPercentage : Int = 20
    
    @FocusState private var amountIsFocused : Bool
    
    let tipPercentages : [Int] = [10, 15, 20, 25, 0]
    
    var totalPerPerson : Double {
        let peopleCount : Double = Double(numberOfPeople + 2)
        
        let grandTotal = totalAmount
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount : Double {
        let tipSelection : Double = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percantage", selection: $tipPercentage) {
                        ForEach(0..<101 ) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total amount")
                        .background((tipPercentage == 0) ? .red : .white)
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("We split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
