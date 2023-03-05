//
//  ContextMenuView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 15/02/2023.
//

import SwiftUI

struct ContextMenuView: View {
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) {
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                    }
                    
                    Button("Green") {
                        backgroundColor = .green
                    }
                    
                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

struct ContextMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuView()
    }
}
