//
//  ActivityView.swift
//  ActivityTracker
//
//  Created by Paulina Dąbrowska on 24/01/2023.
//

import SwiftUI

struct ActivityView: View {
    
    var activity : Activity
    var activities : Activities
    
    var body: some View {
        NavigationView {
            
            VStack() {
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Description")
                            .font(.headline)
                        Spacer()
                    }
                    
                    Text(activity.description)
                    
                }
                .padding(.top)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                VStack(spacing: 20) {
                    Text("Performed \(activity.timesDone) times")
                    
                    Button {
                        let newActivity = Activity(name: activity.name, description: activity.description, timesDone: activity.timesDone + 1)
                        let index = activities.activities.firstIndex(of: activity)
                        
                        activities.activities[index ?? 0] = newActivity
                    } label: {
                        Text("I just did it!")
                            .padding(10)
                            .foregroundColor(.black)
                            .font(.body.bold())
                            .background(.teal)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            
            .navigationTitle(activity.name)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static let activity = Activity(name: "test activity", description: "my test description  ebebe")
    static var previews: some View {
        ActivityView(activity: activity, activities: Activities())
    }
}
