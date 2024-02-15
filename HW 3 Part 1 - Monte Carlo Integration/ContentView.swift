//
//  ContentView.swift
//  Monte Carlo Integral
//
//  Created by Marco on 2/15/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var guessesString = "1" // Default number of guesses
    @State private var totalGuessString = "0"
    @State private var integralResultString = "0.0"
    
    //This sets up the GUI in which Monte Carlo integraitons are displayed.
    
    @ObservedObject private var monteCarloIntegral = MonteCarloIntegral(withData: true)
    
    
    //GUI Visual
    var body: some View {
        VStack {
            HStack {
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
                        .disabled(true) // Total guesses doesn't need to be editable
                    
                    Text("Integral Result (e^-x dx)")
                        .font(.headline)
                    TextField("Integral Result", text: $integralResultString)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disabled(true)
                }
                
                Spacer()
            }
            .padding()
   
      //Button for Integral Calculation
            
            HStack {
                Button("Integral Calculation") {
                    Task {
                        await calculateIntegral()
                    }
                }
                .padding()
                .disabled(monteCarloIntegral.enableButton == false)
    
       //Button for "Clear" button
                
                Button("Clear") {
                    clearFields()
                }
                .padding()
            }
            
            Spacer()
        
        }
    }
    
    //Function in which to calculate inegral.
    
    private func calculateIntegral() async {
        let guesses = Int(guessesString) ?? 100
        monteCarloIntegral.setButtonEnable(state: false)
        
        let result = await monteCarloIntegral.calculateIntegralForExponential(n: guesses)
        
        integralResultString = String(format: "%.5f", result)
        totalGuessString = "\(Int(totalGuessString)! + guesses)"
        
        monteCarloIntegral.setButtonEnable(state: true)
    }
    
    
    // Function to clear the input and result fields, resetting to default values
    
    private func clearFields() {
        guessesString = "100"
        totalGuessString = "0"
        integralResultString = "0.0"
        monteCarloIntegral.resetData()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

