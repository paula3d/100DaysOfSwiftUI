//
//  PublishedWithCodable.swift
//  CupcakeCorner
//
//  Created by Paulina Dąbrowska on 25/01/2023.
//

//
// using @Published with Codable
//

import Foundation

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
    
    enum CodingKeys: CodingKey {
        case name
    }
}
