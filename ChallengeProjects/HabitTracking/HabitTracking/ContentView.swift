//
//  ContentView.swift
//  HabitTracking
//
//  Created by Paulina Dąbrowska on 23/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var userActivities = Activities()
    
    @State private var addingActivity = false
    
    @State private var showingAlert = false
    @State private var deleteActivity = false
    @State private var index : IndexSet = IndexSet()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(userActivities.activityGroups) { activityGroup in
                    ActivityGroupElement(activityGroup: activityGroup)
                }
                .onDelete(perform: removeActivities)
            }
            .navigationTitle("Your activities")
            .toolbar {
                Button {
                    // display a sheet where user can add new activity
                    addingActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $addingActivity) {
                AddActivityGroupView(userActivities: userActivities)
            }
            .alert("Warning", isPresented: $showingAlert) {
                Button("Delete", role: .destructive) {
                    // delete the group of activities
                    deleteActivity = true
                    removeActivities(at: index)
                }
                Button("Cancel", role: .cancel) {
                    // do nothing
                }
            } message: {
                Text("You are about to delete a group of activities.")
            }
        }
    }
    func removeActivities(at offsets: IndexSet) {
        
        showingAlert = true
        index = offsets
        
        if deleteActivity {
            userActivities.activityGroups.remove(atOffsets: offsets)
        }
    }
}

// The entry of a single activity group
struct ActivityGroupElement : View {
    
    let activityGroup : ActivityGroup
    let activityEntry = ActivityEntry(date: Date.now, notes: "placeholder")
    
    var body: some View {
        NavigationLink {
            ActivityView()
        } label: {
            VStack(alignment: .leading){
                Text(activityGroup.name)
                    .font(.headline)
                Text("Last done: \(activityEntry.dateForDisplay)")
                    .font(.subheadline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
