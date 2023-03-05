//
//  CoreDataTutorialView.swift
//  Bookworm
//
//  Created by Paulina Dąbrowska on 27/01/2023.
//

/** ASSOCIATED
 
 add this variable to the App file:
 @StateObject private var dataController = DataController()
 
 and the following modifier to the ContentView()
 var body: some Scene {
     WindowGroup {
        CoreDataTutorialView()
             .environment(\.managedObjectContext, dataController.container.viewContext)
     }
 }
 */


import SwiftUI

struct CoreDataTutorialView: View {
    
    @FetchRequest(sortDescriptors: []) var students: FetchedResults<Student>
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!

                let student = Student(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                
                try? moc.save()
            }
        }
    }
}

struct CoreDataTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataTutorialView()
    }
}
