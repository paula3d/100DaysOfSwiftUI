//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Paulina Dąbrowska on 29/01/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }

            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"

                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"

                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"

                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"

                try? moc.save()
            }
        }
    }
    
    /*
    
    // singers example - sorting the data based on parameters
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            // list of matching singers
            
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer: Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            // FilteredList(filter: lastNameFilter)

            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"

                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"

                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"

                try? moc.save()
            }

            Button("Show A") {
                lastNameFilter = "A"
            }

            Button("Show S") {
                lastNameFilter = "S"
            }
        }
    }
    */
    
    /*
    // Ships case - filtering fetched properties
    @Environment(\.managedObjectContext) var moc
    
    // fethes only ships that are from Star Wars universe
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships: FetchedResults<Ship>
    
    /**
     the predicate can be wrote in different ways
     
     NSPredicate(format: "universe == %@", "Star Wars"))
     
     NSPredicate(format: "name < %@", "F"))
     
     NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
     
     NSPredicate(format: "name BEGINSWITH %@", "E"))
     
     NSPredicate(format: "name BEGINSWITH[c] %@", "e")) // <- ignores the case sensitivity
     
     NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
     */

        var body: some View {
            VStack {
                List(ships, id: \.self) { ship in
                    Text(ship.name ?? "Unknown name")
                }

                Button("Add Examples") {
                    let ship1 = Ship(context: moc)
                    ship1.name = "Enterprise"
                    ship1.universe = "Star Trek"

                    let ship2 = Ship(context: moc)
                    ship2.name = "Defiant"
                    ship2.universe = "Star Trek"

                    let ship3 = Ship(context: moc)
                    ship3.name = "Millennium Falcon"
                    ship3.universe = "Star Wars"

                    let ship4 = Ship(context: moc)
                    ship4.name = "Executor"
                    ship4.universe = "Star Wars"

                    try? moc.save()
                }
            }
        }
    */
    
    
    /*
     
     // Wizards case -> removing duplicates
     
     @Environment(\.managedObjectContext) var moc

         @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

         var body: some View {
             VStack {
                 List(wizards, id: \.self) { wizard in
                     Text(wizard.name ?? "Unknown")
                 }

                 Button("Add") {
                     let wizard = Wizard(context: moc)
                     wizard.name = "Harry Potter"
                 }

                 Button("Save") {
                     do {
                         try moc.save()
                     } catch {
                         print(error.localizedDescription)
                     }
                 }
             }
         }
     */
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
