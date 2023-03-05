//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Paulina Dąbrowska on 15/01/2023.
//

import Foundation

struct ExpenseItem : Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
