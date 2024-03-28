//
//  HW_3_Part_1___Monte_Carlo_IntegrationApp.swift.swift
//  HW 3 Part 1 - Monte Carlo Integration
//
//  Created by Marco on 2/8/24.
//

import SwiftUI

@main
struct HW3Part1MonteCarloIntegrationApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                MonteCarloIntegrationContentView()
                    .tabItem {
                        Label("Part 1 - Monte Carlo Integration", systemImage: "function")
                    }
                
                ShieldingCalculationsContentView()
                    .tabItem {
                        Label("Part 2 - Shielding Test Calculations", systemImage: "shield")
                    }
            }
        }
    }
}
