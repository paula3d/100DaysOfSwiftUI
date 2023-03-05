//
//  ContentView.swift
//  iExpense
//
//  Created by Paulina Dąbrowska on 15/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }

                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(item.amount > 10 ? item.amount > 100 ? Color.red : Color.yellow : Color.green)
                    }
                    .accessibilityElement()
                    .accessibilityLabel("\(item.name), \(item.amount)")
                    .accessibilityHint(item.type)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {

                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
