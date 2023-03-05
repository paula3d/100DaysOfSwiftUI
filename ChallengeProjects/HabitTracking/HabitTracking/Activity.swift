//
//  Activity.swift
//  HabitTracking
//
//  Created by Paulina Dąbrowska on 23/01/2023.
//

import Foundation

struct ActivityEntry : Identifiable, Codable {
    var id = UUID()
    
    var timesDone : Int = 0
    
    var date : Date
    
    let notes : String?
    
    var dateForDisplay : String {
        return date.formatted(.dateTime.day().month().year())
    }
}
