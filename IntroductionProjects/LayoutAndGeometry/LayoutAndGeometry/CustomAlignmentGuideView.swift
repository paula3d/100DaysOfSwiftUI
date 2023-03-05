//
//  CustomAlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by Paulina Dąbrowska on 22/02/2023.
//

import SwiftUI

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image("paul-hudson")
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            .background(.red)
            
            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
            .background(.red)
        }
    }
}

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }
    
    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlignmentGuideView()
    }
}
