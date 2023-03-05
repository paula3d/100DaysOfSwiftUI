//
//  AddActivityView.swift
//  ActivityTracker
//
//  Created by Paulina Dąbrowska on 24/01/2023.
//

import SwiftUI

struct AddActivityView: View {
    
    @ObservedObject var activities : Activities
    
    @State private var activityName = ""
    @State private var activityDescription = ""
    
    let nameLimit = 30
    let descriptionLimit = 200
    
    @State private var nameNotFilled = true
    @State private var errorMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Add activity name", text: $activityName)
                        .onChange(of: activityName, perform: {
                            activityName = String($0.prefix(nameLimit))
                            if activityName.count != 0 {
                                // if name filled
                                if isUnique() {
                                    // if name is unique
                                    nameNotFilled = false
                                } else {
                                    nameNotFilled = true
                                }
                            } else {
                                // if name empty
                                nameNotFilled = true
                            }
                        })
                } header: {
                    Text("Activity name")
                } footer: {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                Section {
                    if #available(iOS 16.0, *) {
                        TextField("Activity description", text: $activityDescription, prompt: Text("Describe the activity (Optional)"), axis: .vertical)
                            .onChange(of: activityDescription, perform: {
                                activityDescription = String($0.prefix(descriptionLimit))
                            })
                            .lineLimit(7)
                    } else {
                        // Fallback on earlier versions
                    }
                } header: {
                    Text("Activity description")
                }
            }
            .textInputAutocapitalization(.never)
            .navigationTitle("Add new activity")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Dismiss")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newActivity = Activity(name: activityName.trimmingCharacters(in: .whitespacesAndNewlines), description: activityDescription.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? "N/A" : activityDescription)
                        
                        activities.activities.append(newActivity)
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(nameNotFilled)
                }
            }
        }
    }
    
    func isUnique() -> Bool {
        
        if activities.activities.contains(where: { $0.name.lowercased() == activityName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) }) {
            errorMessage = "There already is an activity with that name."
            return false
        } else {
            errorMessage = ""
            return true
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
