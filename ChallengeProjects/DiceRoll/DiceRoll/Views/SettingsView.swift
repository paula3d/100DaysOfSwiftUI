//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var usersDices : UsersDices
    
    @State var addingDice = false
    
    @State var newDiceSides = 6
    @State var newDiceNumber = 1
    
    var body: some View {
        
        NavigationView {
            if usersDices.dices.isEmpty {
                Text("You have no dices. Add a new dice")
                    .modifier(MyNavigationViewModifier(addingDice: $addingDice))
            } else {
                List {
                    ForEach(usersDices.dices) { dice in
                        HStack {
                            Text("\(dice.sides)-sided dice")
                        }
                    }
                    .onDelete(perform: deleteDice)
                }
                .modifier(MyNavigationViewModifier(addingDice: $addingDice))
            }
                
        }
        .sheet(isPresented: $addingDice) {
            AddDiceView()
        }
    }
    
    func deleteDice(at offsets: IndexSet) {
        for offset in offsets {
            usersDices.remove(at: offset)
            usersDices.save()
        }
    }
}

struct MyNavigationViewModifier : ViewModifier {
    
    @EnvironmentObject var usersDices : UsersDices
    @Binding var addingDice : Bool
    
    func body(content: Content) -> some View {
            content
            .navigationTitle("Your dices")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(usersDices.dices.isEmpty)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addingDice = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(usersDices.dices.count >= 10)
                }
            }
        }
}

struct EditDicesView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
