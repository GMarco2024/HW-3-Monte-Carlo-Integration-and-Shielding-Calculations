//
//  ContentView.swift
//  HW 3 - Shielding Calculations
//
//  ShieldingCalculationsContentView.swift
//
//  Created by Marco on 2/22/24.
//

import SwiftUI


struct ShieldingCalculationsContentView: View {
    
    @State private var pathEnd: [(xPosition: Double, yPosition: Double)] = []
    @State var NumberOfPathsString = "1"
    @State var BeamOffTheGroundString = "4"
    @State var EnergyLossString = ".10"
    @State var NeutronAbsorptionString = ""
    @State var NeutronEscapeeString = ""
    @State var PercentNeutronAbsorbedString = ""
    @State var PercentNeutronEscapeeString = ""
    @State var myNeutron = Neutron(position:CGPoint(x: 0.0,y: 0.0) , initialEnergy: 0.0)
    
    var body: some View {
        
        ScrollView{
            VStack {
                
                Text("HW 3 Shielding Calculations of Neutrons")
                    .underline(true, color: .black)
                    .font(.system(size: 20))
                
                Text("We calculate the Absorption and Escaped Neutrons of a 5m x 5m 2D Wall")
                    .font(.headline)
                    .fontWeight(.regular)
                
                Spacer()
    
                Text("Neutron Paths")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("number of Paths", text: $NumberOfPathsString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Height of Beam Off Ground (In Meters)")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Height in meters", text: $BeamOffTheGroundString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Energy Loss (Percentage)")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Loss of Energy", text: $EnergyLossString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Absorbed Neutrons")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Number of Nuetrons Absorbed by Wall", text: $NeutronAbsorptionString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Percentage of Absorbed Neutrons")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Percentage of Neutrons Absorbed", text: $PercentNeutronAbsorbedString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Escaped Neutrons")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Number of Neutrons Escaped", text: $NeutronEscapeeString)
                    .frame(maxWidth: 350)
                    .padding()
                
                Text("Percentage of Escaped Neutrons")
                    .font(.headline)
                    .fontWeight(.regular)
                
                TextField("Percentage of Neutron Escapees", text: $PercentNeutronEscapeeString)
                    .frame(maxWidth: 350)
                    .padding()
                
                
                Wall(pathEnd: $pathEnd)

                Button(action: {
                    
                 //Number of Neutron Paths
                    
                    let numberOfPaths = Int(NumberOfPathsString) ?? 1
                    let beamHeight = CGFloat(Double(BeamOffTheGroundString.replacingOccurrences(of: "m", with: "")) ?? 4.0)
                    let energyLossPercent = Double(EnergyLossString) ?? 0.10
                    
                // Beam Height
                    
                    let results = myNeutron.simulateNeutronPaths(numberOfPaths: numberOfPaths, beamHeight: beamHeight, energyLossPercent: energyLossPercent, initialEnergy: 1.0, wallDimensions: CGSize(width: 5, height: 5))
                    
                // Update UI with simulation results
                    NeutronAbsorptionString = "\(results.absorbed)"
                    NeutronEscapeeString = "\(results.escaped)"
                    pathEnd = results.endPositions
                    
                // Calculate the percentage of neutrons absorbed and escaped based on the simulation results
                    let total = results.absorbed + results.escaped
                    let percentAbsorbed = total > 0 ? (Double(results.absorbed) / Double(total)) * 100 : 0
                    let percentEscaped = total > 0 ? (Double(results.escaped) / Double(total)) * 100 : 0
                    
                    PercentNeutronAbsorbedString = "\(percentAbsorbed)%"
                    PercentNeutronEscapeeString = "\(percentEscaped)%"
                    
                })
                {
                    
                 //Button Label of Course
                    Text("Simulate Neutron Paths")
                }

                
                    
                }
                .padding()
                
             
             }
                .padding()
        }
    }

                              
    
