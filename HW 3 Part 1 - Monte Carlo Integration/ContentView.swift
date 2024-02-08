import SwiftUI

struct ContentView: View {
    @State private var n: String = ""
    @State private var nValueForGuesses: String = ""  "Enter N"
    @State private var investigationResults: [String] = []

    var body: some View {
        ScrollView {
            VStack {
                Text("Problem 3 Part 1 - Monte Carlo Integration")
                    .font(.title)
                    .underline()
                
                Text("Evaluation of e^-x over the interval from 0 to 1")
                    .font(.headline)
                    .fontWeight(.regular)
                
                Text("using n = 10, 20, 50, 100, 200, 500, 10000, 10000, 50000.")
                    .font(.headline)
                    .fontWeight(.regular)

                TextField("Enter value of n", text: $n)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 330)
                    .padding()
                
                Button("Calculate Iteration") {
                    if let numberOfIterations = Int(n) {
                        let result = calculateMonteCarloIntegration(iterations: numberOfIterations)
                        print("Result of Monte Carlo integration: \(result)")
                        investigationResults.append("Result: \(result)")
                    } else {
                        print("Invalid input for n")
                    }
                }
                .padding()
           
                if !investigationResults.isEmpty {
                    Text("Integration Result: \(investigationResults.last!)")
                        .padding()
                }

              
                TextField("Enter N", text: $nValueForGuesses)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: 330)
                    .padding()

                Button("Calculate Guesses") {
                  
                }
                .padding()
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


