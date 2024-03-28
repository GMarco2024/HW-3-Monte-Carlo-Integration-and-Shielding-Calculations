//
//  MonteCarloIntegration.swift
//  Monte Carlo Integral
//
//  Created by Marco on 2/15/24.
//

import Foundation
import SwiftUI

class MonteCarloIntegral: ObservableObject {
    
    @Published var enableButton = true
    
    // Initializer
    init(withData data: Bool = true) {
        // Initialize with any required data, if needed
    }
    
    /// Calculates the integral of e^-x dx over [0, 1] using Monte Carlo Integration.
    /// - Parameter n: The number of random points to use for the estimation.
    /// - Returns: The estimated value of the integral.
    func calculateIntegralForExponential(n: Int) async -> Double {
        var sum = 0.0
        
        // Perform the Monte Carlo Integration
        for _ in 0..<n {
            let x = Double.random(in: 0...1)
           
        //This evaluates e^-x at this point and add it to the sum
        
            sum += exp(-x)
        }
        
        let averageValue = sum / Double(n)
        
        return averageValue
    }
    
    // Reset any data that needs to be cleared when the "Clear" button is pressed
    func resetData() {
   
    }
    
    /// Sets the enable state of the UI button.
    /// - Parameter state: The boolean state to set for the button's enabled property.
    func setButtonEnable(state: Bool) {
        DispatchQueue.main.async {
            self.enableButton = state
        }
    }
}

