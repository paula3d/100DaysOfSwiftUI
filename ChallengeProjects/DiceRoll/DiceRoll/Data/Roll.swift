//
//  Roll.swift
//  DiceRoll
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import Foundation

class Roll : Identifiable, Codable {
    var id : UUID
    var rolledDices : [Dice]
    var rolledValues : [Int]
    
    var summedValue : Int {
        var sum = 0
        for value in rolledValues {
            sum += value
        }
        return sum
    }
    
    init() {
        self.id = UUID()
        self.rolledDices = [Dice]()
        self.rolledValues = [Int]()
    }
    
    func addDices(_ dices : [Dice]) {
        rolledDices.append(contentsOf: dices)
    }
    
    func addValues(_ values : [Int]) {
        rolledValues.append(contentsOf: values)
    }
}

@MainActor class Rolls : ObservableObject {
    @Published private(set) var rolls: [Roll]
    
    func add(_ roll : Roll) {
        rolls.insert(roll, at: 0)
        
        if rolls.count > 99 {
            rolls.remove(at: rolls.count - 1)
        }
        
        save()
    }
    
    // SAVING DATA
    let savePath = FileManager.documentsDirectory.appendingPathComponent("RollData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            rolls = try JSONDecoder().decode([Roll].self, from: data)
        } catch {
            rolls = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(rolls)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
