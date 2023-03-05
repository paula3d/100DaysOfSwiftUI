//
//  UnderstandingGeaometryReaderView.swift
//  LayoutAndGeometry
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct UnderstandingGeaometryReaderView: View {
    var body: some View {
        GeometryReader { geo in
            Text("Hello, World!")
                .frame(width: geo.size.width * 0.9)
                .background(.red)
        }
        
        VStack {
            GeometryReader { geo in
                Text("Hello, World!")
                    .frame(width: geo.size.width * 0.9, height: 40)
                    .background(.red)
            }
            .background(.green)
            
            Text("More text")
                .background(.blue)
        }
        
        CoordinateSpaceView()
    }
}

struct UnderstandingGeaometryReaderView_Previews: PreviewProvider {
    static var previews: some View {
        UnderstandingGeaometryReaderView()
    }
}

struct CoordinateSpaceView : View {
    var body: some View {
            OuterView()
                .background(.red)
                .coordinateSpace(name: "Custom")
        }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { geo in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)")
                        print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY)")
                        print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}
