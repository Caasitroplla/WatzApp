//
//  PowerZoneCalculator.swift
//  Watz
//
//  Created by Isaac Allport on 05/12/2024.
//

import Foundation

public class PowerZoneCalculator {
    public static func getPowerZones(powerProfile: PowerProfile?) -> [[Int]] {
        // First 4 zones can be calculated based upon threshold
        // Zone 1 = 0% to 55%
        // Zone 2 = to 75%
        // Zone 3 = to 91%
        // Zone 4 = to 105%
        
        // Default values if no power profile is provided
        if powerProfile == nil {
            return [[0, 150], [151, 231], [232, 321], [322, 350], [350, 450], [451, 999]]
        }
        
        let powerProfile = powerProfile!
        
        let threshold = Double(powerProfile.getThreshold())

        var zones: [[Int]] = []

        // For first 4 zones calculate each one based of the previous top boundary + 1

        let zone1 = [0, Int((threshold * 0.55).rounded(.down))]
        let zone2 = [Int((threshold * 0.55).rounded(.up)), Int((threshold * 0.75).rounded(.down))]
        let zone3 = [Int((threshold * 0.75).rounded(.up)), Int((threshold * 0.91).rounded(.down))]
        let zone4 = [Int((threshold * 0.91).rounded(.up)), Int((threshold * 1.05).rounded(.down))]

        zones.append(zone1)
        zones.append(zone2)
        zones.append(zone3)
        zones.append(zone4)

        // For the zones above this we predict the power

        // 5 minute max is the boundary between VO2 and aerobic

        let point = Int(powerProfile.predictPower(time: 300))

        let zone5 = [Int((threshold * 1.05).rounded(.up)), point - 1]

        let zone6 = [point, 999]

        zones.append(zone5)
        zones.append(zone6)

        return zones
    }
}
