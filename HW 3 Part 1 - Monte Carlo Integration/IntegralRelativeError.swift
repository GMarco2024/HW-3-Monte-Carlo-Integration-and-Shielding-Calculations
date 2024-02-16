//
//  IntegralRelativeError.swift
//  Monte Carlo Integral
//
//  Created by Marco on 2/15/24.
//

import Foundation

struct IntegralRelativeError {
    
    // Define Euler's number directly
    static let e = 2.718281828459045
    
    // The exact value of the integral of e^-x dx from 0 to 1, calculated as 1 - e^-1
    static let exactValue = 1 - pow(e, -1)
    
    /// Calculates the relative error between the estimated value from Monte Carlo integration and the exact value of the integral
    static func calculateRelativeError(estimate: Double) -> Double {
        return abs((exactValue - estimate) / exactValue)
    }
}



