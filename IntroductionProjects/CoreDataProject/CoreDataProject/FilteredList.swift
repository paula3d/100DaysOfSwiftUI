//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Paulina Dąbrowska on 29/01/2023.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K \(Predicate.beginsWith) %@", filterKey, filterValue)) // %K is for key
        self.content = content
    }
}

enum Predicate : String {
    case beginsWith = "BEGINSWITH"
}

/*
 
 //
 //  In this example, the filers only work with Singer class
 //
 
struct FilteredList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Singer>
    
    init(filter: String) {
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
     */
