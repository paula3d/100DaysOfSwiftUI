//
//  Prospect.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 15/02/2023.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    
    // UserDefaults approach
    /*
     let saveKey = "SavedData"
     
     init() {
         if let data = UserDefaults.standard.data(forKey: saveKey) {
             if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                 people = decoded
                 return
             }
         }

         people = []
     }
     
     private func save() {
         if let encoded = try? JSONEncoder().encode(people) {
             UserDefaults.standard.set(encoded, forKey: saveKey)
         }
     }
     */
    
    // documents directory approach
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
