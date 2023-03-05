//
//  Dice.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import Foundation

class Dice : Identifiable, Codable, Hashable {
    static func == (lhs: Dice, rhs: Dice) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id : UUID
    var sides : Int
    var totalRolled : Int
    
    init(sides : Int) {
        self.id = UUID()
        self.sides = sides
        self.totalRolled = 0
    }
    
    func addToTotal(_ num : Int) {
        totalRolled += num
    }
}

@MainActor class Dices : ObservableObject {
    @Published private(set) var dices: [Dice]
    
    let availableDices = [
        Dice(sides: 4),
        Dice(sides: 6),
        Dice(sides: 8),
        Dice(sides: 10),
        Dice(sides: 12),
        Dice(sides: 20),
        Dice(sides: 100)
    ]
    
    func addToTotal(dice : Dice, num : Int){
        dices.first(where: {$0.sides == dice.sides})?.addToTotal(num)
        save()
    }
    
    func getTotalValue(_ dice : Dice) -> Int {
        return dices.first(where: { $0.sides == dice.sides })?.totalRolled ?? 0
    }
    
    // SAVING DATA
    let savePath = FileManager.documentsDirectory.appendingPathComponent("DiceData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            dices = try JSONDecoder().decode([Dice].self, from: data)
        } catch {
            dices = availableDices
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(dices)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

@MainActor class UsersDices : ObservableObject {
    @Published private(set) var dices : [Dice]
    @Published private(set) var rolling : Bool
    
    func add(_ dice : Dice) {
        setRolling(to: false)
        dices.append(dice)
        save()
    }
    
    func remove(at index: Int) {
        setRolling(to: false)
        dices.remove(at: index)
        save()
    }
    
    func setRolling(to bool : Bool) {
        rolling = bool
    }
    
    // SAVING DATA
    let savePath = FileManager.documentsDirectory.appendingPathComponent("UserDiceData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            dices = try JSONDecoder().decode([Dice].self, from: data)
        } catch {
            dices = []
        }
        rolling = false
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(dices)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
