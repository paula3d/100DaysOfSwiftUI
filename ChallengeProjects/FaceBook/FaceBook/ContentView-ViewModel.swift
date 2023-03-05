//
//  ContentView-ViewModel.swift
//  FaceBook
//
//  Created by Paulina Dąbrowska on 11/02/2023.
//

import Foundation
import UIKit

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var people : [Person]
        
        @Published var inputImage : UIImage?
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
