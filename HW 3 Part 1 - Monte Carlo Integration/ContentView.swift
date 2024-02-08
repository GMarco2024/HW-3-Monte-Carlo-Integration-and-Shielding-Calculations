import SwiftUI

struct ContentView: View {
    @State private var roots: [String] = []
    @State private var n: String = ""
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
                
                Text("using n = 10 ,20 ,50 ,100 , 200, 500 , 10000, 10000, 50000.")
                    .font(.headline)
                    .fontWeight(.regular)

                HStack {
                    TextField("Enter value of n", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 330)
                        .padding()
                }

                Button("Calculate Iteration") {
             
                }
               
                    }
                }
                .padding()
            }
  
        }
    


