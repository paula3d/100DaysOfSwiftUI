//
//  AllowsHitTestingView.swift
//  Flashzilla
//
//  Created by Paulina Dąbrowska on 19/02/2023.
//

import SwiftUI

struct AllowsHitTestingView: View {
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Circle tapped!")
                }
                .allowsHitTesting(false)
        }
    }
}

struct AllowsHitTestingView_Previews: PreviewProvider {
    static var previews: some View {
        AllowsHitTestingView()
    }
}

struct ContentShapeView : View {
    var body: some View {
        
        // case 1
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }

            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
        }
        
        // case 2
        // in this case, the spacer is not tapable
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .onTapGesture {
            print("VStack tapped!")
        }
        
        // addint the contentShape modifier, the whole vstack is tapable
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}
