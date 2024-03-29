//
//  ContentView.swift
//  HW 3 - Shielding Calculations
//
//  PathPositions.swift
//
//  Created by Marco on 2/22/24.
//

import SwiftUI

struct PathPositions: View {
    @Binding var pathEnd: [(xPosition: Double, yPosition: Double)]

    // Defines the size of each particle visualization
    
    private let particleSize: CGFloat = 5
    
    // The height of the background for scaling the positions
    
    private let backgroundWidth: CGFloat = 500
    private let backgroundHeight: CGFloat = 500

    var body: some View {
        
        ForEach(pathEnd.indices, id: \.self) { index in
                    let position = pathEnd[index]
                    drawParticle(at: position)
        }
    }

    //This generates particles on the screen of wall.
    
    private func drawParticle(at position: (xPosition: Double, yPosition: Double)) -> some View {
        let scaleX = backgroundWidth / 5.0
        let scaleY = backgroundHeight / 5.0

        let viewX = CGFloat(position.xPosition) * scaleX
        let viewY = CGFloat(position.yPosition) * scaleY
        let correctedY = backgroundHeight - viewY
        
   //Particle propeties such as color and size
        
        return Circle()
            .fill(Color.yellow)
            .frame(width: particleSize, height: particleSize) // Sets the size of the particle
            .offset(x: viewX - backgroundWidth / 2 + particleSize / 2, y: correctedY - backgroundHeight / 2 - particleSize / 2) // Corrects the position to center the particle
        
    }
}

struct PathPositions_Previews: PreviewProvider {
    static var previews: some View {
        PathPositions(pathEnd: .constant([(xPosition: 2.5, yPosition: 2.5), (xPosition: 1.0, yPosition: 3.0)]))
            .frame(width: 600, height: 600, alignment: .center)
    }
}
