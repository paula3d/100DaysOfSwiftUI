//
//  ImgeInterpolationView.swift
//  HotProspects
//
//  Created by Paulina Dąbrowska on 14/02/2023.
//

import SwiftUI

struct ImgeInterpolationView: View {
    var body: some View {
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ImgeInterpolationView_Previews: PreviewProvider {
    static var previews: some View {
        ImgeInterpolationView()
    }
}
