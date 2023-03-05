//
//  ContentView.swift
//  ActivityTracker
//
//  Created by Paulina Dąbrowska on 24/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var activities = Activities()
    
    @State private var addingActivity = false
    
    @State private var showingAlert = false
    @State private var deleteActivity = false
    @State private var index : IndexSet = IndexSet()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        ActivityView(activity: activity, activities: activities)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(activity.name)
                                .font(.headline)
                            Text("Times done: \(activity.timesDone)")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationTitle("Your activities")
            .toolbar {
                Button {
                    addingActivity = true
                } label: {
                    Text(Image(systemName: "plus"))
                }
            }
            .sheet(isPresented: $addingActivity) {
                AddActivityView(activities: activities)
            }
            .alert("Warning", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) {
                    // delete the chosen activity
                    deleteActivity = true
                    removeActivity(at: index)
                }
                Button("Cancel", role: .cancel) {
                    // do nothing
                }
            } message: {
                Text("You are about to delete an activity.")
            }
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        
        showingAlert = true
        index = offsets
        
        if deleteActivity {
            activities.activities.remove(atOffsets: offsets)
            deleteActivity = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
