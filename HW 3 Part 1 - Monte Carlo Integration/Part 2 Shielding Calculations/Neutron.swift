//
//  ContentView.swift
//  HW 3 - Shielding Calculations
//
//  Neutron.swift
//
//  Created by Marco on 2/22/24.
//

import Foundation
import SwiftUI

class Neutron: ObservableObject {
    
    // Position of the Neutron
    @Published var position: CGPoint
    
    // Current Kintenic energy of the Nuetron
    @Published var kineticEnergy: Double
    
    // Average distance (in meters) a neutron travels before colliding
    let meanFreePath: CGFloat = 1.0
    
    // This tracks weather the neutron has escaped the wall
    @Published var hasEscaped: Bool = false
    
    // Initializer to set up a neutron with a starting position and energy

    init(position: CGPoint, initialEnergy: Double) {
        self.position = position
        self.kineticEnergy = initialEnergy
    }

    // Simulates the movement of the neutron based on its mean free path and updates its position and energy accordingly.
    
    func simulateMovement(energyLossPercent: Double, wallDimensions: CGSize) {
        while kineticEnergy > energyLossPercent {
            
    // Random angle for 2D scattering
            
            let angle = Double.random(in: 0..<2 * .pi)
            
    //mycos, mysin, dx, dy was inserted for debugging purposes and to verify calcaulted values
            let mycos = cos(angle)
            let mysin = sin(angle)
            
            let dx = cos(angle) * Double(meanFreePath)
            
            let dy = sin(angle) * Double(meanFreePath)
            
            // Update neutron's position based on the angle and mean free path
            position.x += CGFloat(dx)
            position.y += CGFloat(dy)
            
            // Check if the neutron escapes the defined wall area
            
            if position.x <= 0 || position.x >= wallDimensions.width || position.y <= 0 || position.y >= wallDimensions.height {
                hasEscaped = true
                print("Escaped ",position.x, position.y)
                break
            }
            
           //Kinetic enegy is 100% minus energyLossPercent
            kineticEnergy -= energyLossPercent
            
            // Check for energy depletion
            if kineticEnergy <= energyLossPercent {
                print("Absorbed ",position.x, position.y)
                break // Neutron is absorbed
        
            }
        }
    }

    // Updates the neutron's kinetic energy based on the percentage of energy lost during a collision.
    func energyLoss(percentAbsorption: Double) {
        kineticEnergy *= 1 - percentAbsorption
        kineticEnergy = max(kineticEnergy, 0.0)
    }

    // Returns a boolean indicating whether the neutron has escaped the wall.
    func didEscape() -> Bool {
        return hasEscaped
    }
    
    //Simulation function
    func simulateNeutronPaths(numberOfPaths: Int, beamHeight: CGFloat, energyLossPercent: Double, initialEnergy: Double, wallDimensions: CGSize) -> (absorbed: Int, escaped: Int, endPositions: [(xPosition: Double, yPosition: Double)]) {
        
        //Counter for escaped Neutrons
        var escaped = 0
        
        //Counter for absorbed Neutrons
        var absorbed = 0
        
        //This records the end positions of neutrons.
        var endPositions: [(xPosition: Double, yPosition: Double)] = []
       
        //this initializes a new Neutron for each path.
        for _ in 0..<numberOfPaths {
            let neutron = Neutron(position: CGPoint(x: meanFreePath, y: beamHeight), initialEnergy: initialEnergy)
            neutron.simulateMovement(energyLossPercent: energyLossPercent, wallDimensions: wallDimensions)
            
         // Record the outcome and position based on whether neutron has esaceped or absorbed
            if neutron.didEscape() {
                escaped += 1
                endPositions.append((xPosition: Double(neutron.position.x), yPosition: Double(neutron.position.y)))
            } else {
                absorbed += 1

            }
        }
        
        return (absorbed, escaped, endPositions)
    }
    
}



