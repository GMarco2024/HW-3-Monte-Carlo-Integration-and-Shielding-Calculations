import Foundation

// Define the function to be integrated
func eToTheMinusX(_ x: Double) -> Double {
    return exp(-x)
}

// Define the Monte Carlo integration function
func calculateMonteCarloIntegration(iterations: Int) -> Double {
    var integral = 0.0
  
    for _ in 0..<iterations {
        // Generate random x value between 0 and 1
        let x = Double.random(in: 0...1)
        // Evaluate the function and accumulate integral
        integral += eToTheMinusX(x)
    }
    // Scale by the width of the interval (1)
    integral /= Double(iterations)
    return integral
}
