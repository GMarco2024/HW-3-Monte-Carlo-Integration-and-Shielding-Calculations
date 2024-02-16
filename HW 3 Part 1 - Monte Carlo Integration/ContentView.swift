import SwiftUI

struct ContentView: View {
    
    
// Default number of guesses
    
    @State private var guessesString = "1"
    @State private var totalGuessString = "0"
    @State private var integralResultString = "0.0"
    
// Stores Monte Carlo points for visualization
    
    @State private var monteCarloPoints: [MonteCarloPoint] = []
    
    @ObservedObject private var monteCarloIntegral = MonteCarloIntegral(withData: true)
    
    
    //GUi Visual
    var body: some View {
        VStack {
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
                
                
            }
            .padding()
            
            // Buttons for initiating calculation and clearing data
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
                .border(Color.gray, width: 1)
            
            Spacer()
        }
    }
    
    private func calculateIntegral() async {
        let guesses = Int(guessesString) ?? 0
        monteCarloIntegral.setButtonEnable(state: false)
        
        var sum = 0.0
        for _ in 0..<guesses {
            let x = Double.random(in: 0...1)
            let y = Double.random(in: 0...1)
            let functionValue = exp(-x)
            let isUnderCurve = y <= functionValue
            
            if isUnderCurve {
                sum += functionValue
            }
            
            let newPoint = MonteCarloPoint(xPoint: x, yPoint: y, isUnderCurve: isUnderCurve)
            monteCarloPoints.append(newPoint)
        }
        
// Update total guesses and integral result
      
        let totalGuesses = Int(totalGuessString)! + guesses
        totalGuessString = "\(totalGuesses)"
        
// Calculate the integral result as the average of function values for points under the curve
        let integralResult = sum / Double(guesses)
        integralResultString = String(format: "%.5f", integralResult)
        
        monteCarloIntegral.setButtonEnable(state: true)
    }
    
//Clear Points for a fresh start
    
    private func clearFields() {
        guessesString = "1"
        totalGuessString = "0"
        integralResultString = "0.0"
        monteCarloPoints = []
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
