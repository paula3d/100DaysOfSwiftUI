//
//  AbsolutePositioningView.swift
//  LayoutAndGeometry
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct AbsolutePositioningView: View {
    var body: some View {
        Text("Hello, world!")
            .background(.red)
            .position(x: 100, y: 100)
        
        Text("Hello, world!")
            .position(x: 100, y: 100)
            .background(.red)
        
        Text("Hello, world!")
                .offset(x: 100, y: 100)
                .background(.red)
    }
}

struct AbsolutePositioningView_Previews: PreviewProvider {
    static var previews: some View {
        AbsolutePositioningView()
    }
}
