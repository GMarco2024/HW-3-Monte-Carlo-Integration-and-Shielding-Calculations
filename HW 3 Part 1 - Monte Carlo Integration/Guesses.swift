func generateSingleResult(forN n: Int) -> Double {
    guard n > 0 else { return 0.0 }
    
    let totalSum = (0..<n).reduce(0.0) { currentSum, _ in
        currentSum + Double.random(in: 0...1)
    }
    
    return totalSum / Double(n)
}

