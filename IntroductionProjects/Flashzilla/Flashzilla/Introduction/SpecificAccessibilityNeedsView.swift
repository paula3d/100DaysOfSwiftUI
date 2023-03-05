//
//  SpecificAccessibilityNeedsView.swift
//  Flashzilla
//
//  Created by Paulina Dąbrowska on 19/02/2023.
//

import SwiftUI

struct SpecificAccessibilityNeedsView: View {
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct SpecificAccessibilityNeedsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecificAccessibilityNeedsView()
    }
}

struct ReduceMotionView : View {
    @State private var scale = 1.0
    
    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct ReduceTransparencyView : View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
