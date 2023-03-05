//
//  RowSwipeActionsView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 15/02/2023.
//

import SwiftUI

struct RowSwipeActionsView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Hi")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Hi")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct RowSwipeActionsView_Previews: PreviewProvider {
    static var previews: some View {
        RowSwipeActionsView()
    }
}
