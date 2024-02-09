import SwiftUI

struct ContentView: View {
    @State private var n: String = ""
    @State private var integrationResult: String = ""
    @State private var guessResult: String = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Problem 3 Part 1 - Monte Carlo Integration")
                                    .font(.title)
                                    .underline()
                                
                Text("Evaluation of e^-x over the interval from 0 to 1 using")
                                    .font(.headline)
                                    .fontWeight(.regular)
                                
                Text("n = 10, 20, 50, 100, 200, 500, 10000, 10000, 50000.")
                                    .font(.headline)
                                    .fontWeight(.regular)
                
                TextField("Enter value of N", text: $n)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 300)
                    .padding()
                
                Button("Calculate") {
                    calculateBoth()
                }
                .padding()
                
                if !integrationResult.isEmpty {
                    Text(" \(integrationResult)")
                        .padding()
                }
                
                if !guessResult.isEmpty {
                    Text(guessResult)
                        .padding()
                }
            }
            .padding()
        }
    }
    
    func calculateBoth() {
        guard let nValue = Int(n) else {
            print("Invalid input for N")
            return
        }
        
        // Calculate Monte Carlo Integration
        let integrationValue = calculateMonteCarloIntegration(iterations: nValue)
        integrationResult = "Integration Result: \(integrationValue)"
        
        // Calculate Guess Result
        let singleGuessResult = generateSingleResult(forN: nValue)
        guessResult = "Guess Result: \(singleGuessResult)"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










