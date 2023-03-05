//
//  Activities.swift
//  ActivityTracker
//
//  Created by Paulina Dąbrowska on 24/01/2023.
//

import Foundation

class Activities : ObservableObject {
    
    @Published var activities = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([Activity].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }
        
        activities = []
    }
}
