//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 17/02/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
