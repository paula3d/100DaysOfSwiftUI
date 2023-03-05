//
//  AddActivityView.swift
//  HabitTracking
//
//  Created by Paulina Dąbrowska on 23/01/2023.
//

import SwiftUI

struct AddActivityGroupView: View {
    
    @ObservedObject var userActivities : Activities
    
    @State private var activityName = ""
    @State private var activityDescription = ""
    
    @State private var entryDate = Date.now
    @State private var entryNotes = ""
    
    let nameLimit = 20
    let descriptionLimit = 200
    
    // lets dismiss the current view
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Activity details") {
                    TextField("Add activity name", text: $activityName)
                        .onChange(of: activityName, perform: {
                            activityName = String($0.prefix(nameLimit))
                        })
                    
                    
                    TextField("Activity description", text: $activityDescription, prompt: Text("Describe the activity (Optional)"), axis: .vertical)
                        .onChange(of: activityDescription, perform: {
                            activityDescription = String($0.prefix(descriptionLimit))
                        })
                        .lineLimit(6)
                    
                    /*
                     TextEditor(text: $activityDescription)
                     .onChange(of: activityDescription, perform: {
                     activityDescription = String($0.prefix(descriptionLimit))
                     })
                     .lineLimit(10)
                     */
                }
                
                Section("Entry details") {
                    
                    DatePicker("When?", selection: $entryDate)
                    
                    TextField("Entry notes", text: $entryNotes, prompt: Text("Add notes (Optional)"), axis: .vertical)
                        .onChange(of: entryNotes, perform: {
                            entryNotes = String($0.prefix(descriptionLimit))
                        })
                        .lineLimit(6)
                }
            }
            .textInputAutocapitalization(.never)
            .navigationTitle("Add new activity")
            .toolbar {
                Button("Save") {
                    
                    let newActivityEntry = ActivityEntry(date: entryDate, notes: entryNotes)
                    
                    let newActivityGroup = ActivityGroup(
                        activityEntries: [newActivityEntry],
                        name: activityName,
                        description: activityDescription == "" ? "N/A" : activityDescription)
                    
                    
                    userActivities.activityGroups.append(newActivityGroup)
                    print(userActivities.activityGroups[0].name)
                    print(userActivities.activityGroups[0].activityEntries[0].dateForDisplay)
                    dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityGroupView(userActivities: Activities())
    }
}
