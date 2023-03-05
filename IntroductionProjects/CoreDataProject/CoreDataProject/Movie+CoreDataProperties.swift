//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Paulina Dąbrowska on 29/01/2023.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    var wrappedTitle : String {
        title ?? "Unknown title"
    }

}

extension Movie : Identifiable {

}
