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
    var monteCarloPoints: [MonteCarloPoint]
    
    var body: some View {
        GeometryReader { geometry in
            // Drawing the curve of e^-x
            Path { path in
                for x in stride(from: 0.0, through: 1.0, by: 0.01) {
                    let y = exp(-x)
                    let scaledX = CGFloat(x) * geometry.size.width
                    let scaledY = (1 - CGFloat(y)) * geometry.size.height // Flip y-axis
                    if x == 0 {
                        path.move(to: CGPoint(x: scaledX, y: scaledY))
                    } else {
                        path.addLine(to: CGPoint(x: scaledX, y: scaledY))
                    }
                }
            }
            .stroke(Color.red, lineWidth: 2)
            
            // Displaying Monte Carlo points. These are the properties of the points generated.
            
            ForEach(monteCarloPoints, id: \.self) { point in
                Circle()
                    .fill(point.isUnderCurve ? Color.red : Color.blue)
                    .frame(width: 5, height: 5)
                    .position(
      
                        //This calcualtes the position of each point to match the scaled drawing
                        x: CGFloat(point.xPoint) * geometry.size.width,
                        y: (1 - CGFloat(point.yPoint)) * geometry.size.height //
                        
                    )
            }
        }
    }
}

struct MonteCarloDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        // Example points for preview
        let examplePoints = [
            MonteCarloPoint(xPoint: 0.1, yPoint: 0.9, isUnderCurve: false),
            MonteCarloPoint(xPoint: 0.2, yPoint: 0.8, isUnderCurve: true)
        ]
        
        MonteCarloDrawingView(monteCarloPoints: examplePoints)
            .frame(width: 300, height: 300)
    }
}
