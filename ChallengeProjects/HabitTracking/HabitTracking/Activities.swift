//
//  Activities.swift
//  HabitTracking
//
//  Created by Paulina Dąbrowska on 23/01/2023.
//

import Foundation

class Activities : ObservableObject {
    var activityGroups = [ActivityGroup]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activityGroups) {
                UserDefaults.standard.set(encoded, forKey: "Groups")
            }
        }
    }
    
    init() {
        if let savedGroups = UserDefaults.standard.data(forKey: "Groups") {
            if let decodedItems = try? JSONDecoder().decode([ActivityGroup].self, from: savedGroups) {
                activityGroups = decodedItems
                return
            }
        }

        activityGroups = []
    }
}
