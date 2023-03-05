//
//  ActivityGroup.swift
//  HabitTracking
//
//  Created by Paulina Dąbrowska on 23/01/2023.
//

import Foundation

struct ActivityGroup : Identifiable, Codable {
    var id = UUID()
    
    var activityEntries = [ActivityEntry]()
    
    var name : String
    var description : String?
}
