//
//  MonteCarloIntegrationContentView.swift
//  Monte Carlo Integral
//
//  Created by Marco on 2/15/24.
//

import SwiftUI
import Foundation

// Default number of guesses

struct MonteCarloIntegrationContentView: View {
    @State private var guessesString = "1"
    @State private var totalGuessString = "0"
    @State private var integralResultString = "0.0"
    @State private var relativeErrorString = "N/A"
    
// Stores Monte Carlo points for visualization
    
    @State private var monteCarloPoints: [MonteCarloPoint] = []
    
// Monte Carlo calculation object

    @ObservedObject private var monteCarloIntegral = MonteCarloIntegral(withData: true)
    
    var body: some View {
        TabView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Guesses")
                        .font(.headline)
                    TextField("Number of Guesses", text: $guessesString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom, 20)
                    
                    Text("Total Guesses")
                        .font(.headline)
                    TextField("Total Guesses", text: $totalGuessString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true) // This makes it so that the box isn't directly editable
                    
                    Text("Integral Result (e^-x dx)")
                        .font(.headline)
                    TextField("Integral Result", text: $integralResultString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true) // This makes it so that the box isn't directly editable
                    
                    Text("Relative Error: \(relativeErrorString)")
                        .font(.headline)
                        .padding(.top, 5)
                }
                .padding()
      
                
// Buttons for initiating the calculation and clearing the data
                
                HStack {
                    Button("Integral Calculation") {
                        Task {
                            await calculateIntegral()
                        }
                    }
                    .padding()
                    .disabled(monteCarloIntegral.enableButton == false)
                    
                    Button("Clear") {
                        clearFields()
                    }
                    .padding()
                }

// Visual representation of the Monte Carlo integration

                MonteCarloDrawingView(monteCarloPoints: monteCarloPoints)
                    .padding()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 250, maxHeight: 250)
                    .border(Color.gray, width: 1)
            }
            

            
    
        }
    }
    
    private func calculateIntegral() async {
        let guesses = Int(guessesString) ?? 0
        monteCarloIntegral.setButtonEnable(state: false)
   
        
// Generate random points and calculate the function value at each point

        var sum = 0.0
        for _ in 0..<guesses {
            let x = Double.random(in: 0...1)
            let y = Double.random(in: 0...1)
            let functionValue = pow(2.718281828459045, -x)
            let isUnderCurve = y <= functionValue
            
    // Accumulate function values for points under the curve
            
            if isUnderCurve {
                sum += functionValue
            }
            
            let newPoint = MonteCarloPoint(xPoint: x, yPoint: y, isUnderCurve: isUnderCurve)
            monteCarloPoints.append(newPoint)
        }
        
// Update total guesses and calculate the integral result
        
        let totalGuesses = Int(totalGuessString)! + guesses
        totalGuessString = "\(totalGuesses)"
        
// Integral result based on Monte Carlo method. In this line .5 indicates the number of decimals to display for any result calculated.
        
        let integralResult = sum / Double(guesses)
        integralResultString = String(format: "%.5f", integralResult)
        
        let exactValue = 1 - 1 / 2.718281828459045
        let relativeError = abs((exactValue - integralResult) / exactValue)
     
 // Decimal place value. In this line .5 indicates the number of decimals to display for any result calculated.
        
        relativeErrorString = String(format: "%.5f", relativeError)
        
        monteCarloIntegral.setButtonEnable(state: true)
    }
   

// Resets all fields and clears the points for a new calculation
    
    
    private func clearFields() {
        guessesString = "1"
        totalGuessString = "0"
        integralResultString = "0.0"
        monteCarloPoints = []
        relativeErrorString = "N/A"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MonteCarloIntegrationContentView()
    }
}
