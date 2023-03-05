//
//  ChallengeView.swift
//  LayoutAndGeometry
//
//  Created by Paulina Dąbrowska on 24/02/2023.
//

import SwiftUI

struct ChallengeView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

        var body: some View {
            
            GeometryReader { fullView in
                ScrollView(.vertical) {
                    ForEach(0..<50) { index in
                        GeometryReader { geo in
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(width: max(fullView.size.width * 0.4, fullView.size.width * (geo.frame(in: .global).midY / fullView.size.height)))
                                .background(Color(hue: min(1 , geo.frame(in: .global).midY / fullView.size.height), saturation: 1, brightness: 1))
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                .opacity(geo.frame(in: .global).midY < 200 ? geo.frame(in: .global).midY / 200 : 1)
                                .onTapGesture {
                                    print(fullView.size.width)
                                    print("Row # \(index): \(geo.frame(in: .global).width)")
                                    
                                }
                        }
                        .frame(height: 40)
                    }
                }
            }
        }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
