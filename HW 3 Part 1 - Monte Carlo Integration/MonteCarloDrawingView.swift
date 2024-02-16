import SwiftUI

struct MonteCarloDrawingView: View {
    var numberOfPoints: Int = 100 // Number of Monte Carlo points to display
    var functionPoints: [(xPoint: Double, yPoint: Double)] = []
    var monteCarloPoints: [(xPoint: Double, yPoint: Double, isUnderCurve: Bool)] = []
    
    init() {
        // Generate points for the e^-x curve
        for x in stride(from: 0.0, through: 1.0, by: 0.01) {
            let y = exp(-x)
            functionPoints.append((xPoint: x, yPoint: y))
        }
        
        // Generate random points for the Monte Carlo method visualization
        for _ in 0..<numberOfPoints {
            let x = Double.random(in: 0...1)
            let y = Double.random(in: 0...1)
            let isUnderCurve = y <= exp(-x)
            monteCarloPoints.append((xPoint: x, yPoint: y, isUnderCurve: isUnderCurve))
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for point in functionPoints {
                    let x = geometry.size.width * CGFloat(point.xPoint)
                    let y = geometry.size.height * (1 - CGFloat(point.yPoint)) // Flip y-axis
                    if point == functionPoints.first {
                        path.move(to: CGPoint(x: x, y: y))
                    } else {
                        path.addLine(to: CGPoint(x: x, y: y))
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
