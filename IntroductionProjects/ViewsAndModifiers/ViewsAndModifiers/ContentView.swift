//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Paulina Dąbrowska on 09/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    struct MyModifer: ViewModifier {
        func body(content: Content) -> some View {
            content
                .font(.largeTitle)
                .foregroundColor(.blue)
        }
    }
    
    var body: some View {
        Text("test")
            .modifier(MyModifer())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
