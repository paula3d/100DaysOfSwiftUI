//
//  ArrowView.swift
//  Drawing
//
//  Created by Paulina Dąbrowska on 22/01/2023.
//

import SwiftUI

struct ArrowView: View {
    
    @State private var lineWidth = 20.0
    
    
    @State private var colorCycle = 0.0
    
    var body: some View {
        Arrow()
            .stroke(.gray, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            .frame(width: 150, height: 300)
            .onTapGesture {
                withAnimation {
                    lineWidth = Double.random(in: 2...60)
                }
            }
        
        VStack {
            ColorCyclingRectangle(amount: colorCycle)
        .frame(width: 300, height: 300)
        
        Slider(value: $colorCycle)
        }
        
    }
}

struct ColorCyclingRectangle : View {
    var amount = 0.0
    var steps = 100
    
    var body : some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                        gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                        ),
                        lineWidth: 55
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Arrow : Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + rect.maxX / 2, y: rect.maxY / 3))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX - rect.maxX / 2, y: rect.maxY / 3))
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        return path
    }
    
    
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}
