//
//  Person.swift
//  FaceBook
//
//  Created by Paulina Dąbrowska on 11/02/2023.
//

import Foundation
import UIKit
import CoreLocation

struct Person : Identifiable, Comparable, Codable {
    
    var id : UUID
    var name : String
    var imageData : Data
    
    let latitude: Double
    let longitude: Double
    
    
    var image : UIImage  {
        guard let image = UIImage(data: imageData) else {
            print("Could not decode image data.")
            
            return UIImage(named: "placeholderImage")!
        }
        return image
    }
    
    var location : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
