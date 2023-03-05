//
//  Activity.swift
//  ActivityTracker
//
//  Created by Paulina Dąbrowska on 24/01/2023.
//

import Foundation

struct Activity : Identifiable, Codable, Equatable {
    var id = UUID()
    
    let name : String
    let description : String
    
    var timesDone = 1
}
