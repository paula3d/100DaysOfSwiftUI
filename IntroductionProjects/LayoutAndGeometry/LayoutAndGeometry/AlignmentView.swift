//
//  AlignmentView.swift
//  LayoutAndGeometry
//
//  Created by Paulina Dąbrowska on 22/02/2023.
//

import SwiftUI

struct AlignmentView: View {
    var body: some View {
        Text("Live long and prosper")
            .frame(width: 300, height: 300, alignment: .topLeading)
            .offset(x: 10, y: 10)
            .background(.red)
        
        
        HStack(alignment: .lastTextBaseline) {
            Text("Live")
                .font(.caption)
            Text("long")
            Text("and")
                .font(.title)
            Text("prosper")
                .font(.largeTitle)
        }
        
        AlignmentPerView()
        AlignmentGuideView()
    }
}

struct AlignmentView_Previews: PreviewProvider {
    static var previews: some View {
        AlignmentView()
    }
}

struct AlignmentPerView : View {
    var body: some View {
           VStack(alignment: .leading) {
               Text("Hello, world!")
                   .alignmentGuide(.leading) { d in d[.trailing] }
               Text("This is a longer line of text")
           }
           .background(.red)
           .frame(width: 400, height: 400)
           .background(.blue)
       }
}

struct AlignmentGuideView : View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<10) { position in
                Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in CGFloat(position) * -10 }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
    }
}
