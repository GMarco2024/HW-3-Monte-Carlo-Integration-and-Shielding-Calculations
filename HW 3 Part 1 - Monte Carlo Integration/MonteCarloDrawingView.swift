//
//  MonteCarloDrawingView.swift
//  Monte Carlo Integral
//
//  Created by Marco on 2/15/24.
//

import SwiftUI

// Define a struct to represent a point in the Monte Carlo simulation
struct MonteCarloPoint: Hashable {
    var xPoint: Double
    var yPoint: Double
    var isUnderCurve: Bool
}

struct MonteCarloDrawingView: View {
    var numberOfPoints: Int = 100 // Number of Monte Carlo points to display
    var functionPoints: [CGPoint] = [] // Points for the function curve
    var monteCarloPoints: [MonteCarloPoint] = []
    
    init() {
        // Generate points for the e^-x curve
        for x in stride(from: 0.0, through: 1.0, by: 0.01) {
            let y = exp(-x)
            functionPoints.append(CGPoint(x: x, y: y))
        }
        
        // Generate random points for the Monte Carlo method visualization
        for _ in 0..<numberOfPoints {
            let x = Double.random(in: 0...1)
            let y = Double.random(in: 0...1)
            let isUnderCurve = y <= exp(-x)
            monteCarloPoints.append(MonteCarloPoint(xPoint: x, yPoint: y, isUnderCurve: isUnderCurve))
        }
    }
    
    var body: some View {
            GeometryReader { geometry in
                Path { path in
                    for point in functionPoints {
                        let scaledX = CGFloat(point.x) * geometry.size.width
                        let scaledY = (1 - CGFloat(point.y)) * geometry.size.height // Flip y-axis
                        if point == functionPoints.first {
                            path.move(to: CGPoint(x: scaledX, y: scaledY))
                        } else {
                            path.addLine(to: CGPoint(x: scaledX, y: scaledY))
                        }
                    }
                }
                .stroke(Color.red, lineWidth: 2)
            
            ForEach(monteCarloPoints, id: \.self) { point in
                Circle()
                    .fill(point.isUnderCurve ? Color.green : Color.blue)
                    .frame(width: 5, height: 5)
                    .position(x: geometry.size.width * CGFloat(point.xPoint), y: geometry.size.height * (1 - CGFloat(point.yPoint)))
            }
        }
    }
}

struct MonteCarloDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        MonteCarloDrawingView()
            .frame(width: 300, height: 300)
    }
}
