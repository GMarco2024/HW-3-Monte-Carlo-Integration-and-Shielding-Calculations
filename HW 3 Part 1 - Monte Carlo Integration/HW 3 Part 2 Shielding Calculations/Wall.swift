//
//  ContentView.swift
//  HW 3 - Shielding Calculations
//
//  Wall.swift
//
//  Created by Marco on 2/22/24.
//

import SwiftUI

struct Wall: View {
    @Binding var pathEnd: [(xPosition: Double, yPosition: Double)]
    
    var backgroundWidth: CGFloat = 700
    var backgroundHeight: CGFloat = 700
    
    var body: some View {
        ZStack {
            
            
// Drawing the background for the entire view. We make it entirely in black. This sets the size of the rectangle to the specified background dimensions
                        
            Rectangle()
                .fill(Color.black)
                .frame(width: backgroundWidth, height: backgroundHeight)
            
            
// Drawing for the wall in particular. We make it entirely in black. This sets the size of the rectangle to the specified wall dimensions as mentioned.
            
            Rectangle()
                .strokeBorder(Color.white, lineWidth: 1)
                .frame(width: 500, height: 500)
            
            PathPositions(pathEnd: $pathEnd)
                .frame(width: backgroundWidth, height: backgroundHeight)
            
        }
        
    }
    
}


