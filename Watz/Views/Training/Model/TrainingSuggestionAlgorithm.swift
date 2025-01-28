//
//  TrainingSuggestionAlgorithm.swift
//  Watz
//
//  Created by Isaac Allport on 23/01/2025.
//

import Foundation

public class TrainingSuggestionAlgorithm {
    public static func suggestTraining(powerProfile: PowerProfile?, riderType: String) -> String {
        if powerProfile == nil {
            return "Not enough data top suggest any training."
        }
        
        let standardisedCurves: [[Double]] = [
            [447.3325, -0.249, 3.451e-05],  // Climber
            [641.984, -0.357, 4.9543e-05],  // Puncher
            [1103.646 , -0.613, 8.516e-05], // Sprinter
            [833.472 , -0.463, 6.431e-05],  // Time Trialist
            [675.736, -0.376, 5.214e-05]    // All Rounder
        ]
        
        let curveTitle = ["climber", "puncher", "sprinter", "time trialist", "all rounder"]
        
        let preferredCurve = standardisedCurves[curveTitle.firstIndex(of: riderType.lowercased())!]
        
        var standardisedPowerProfile = powerProfile!.getPowerCoefficients()
        standardisedPowerProfile[0] = Double(Double(standardisedPowerProfile.first!) - Double(powerProfile!.predictPower(time: 3600)))
        
        let physiologyZones: [[Double]] = [
            [1.0,120.0],   // Anerobic
            [121.0,480.0], // Vo2 Max and Endurnace
            [481.0,3600.0] // Threshold, Tempo and Endurance
        ]
        
        // Now find where the average distance from the stnadardised power profile to the preferred standardised curve is greatest within the physiology zones
        
        var averages: [Double] = []
        
        // In each physiology zone calculate the distance at the boundries between the two curves
        for i in 0..<physiologyZones.count {
            let zone = physiologyZones[i]
            let lower = getValueWhere(x: zone[0], coefficients: preferredCurve) - getValueWhere(x: zone[0], coefficients: standardisedPowerProfile)
            let upper = getValueWhere(x: zone[1], coefficients: preferredCurve) - getValueWhere(x: zone[1], coefficients: standardisedPowerProfile)
            averages.append((lower + upper) / 2)
        }
        
        // Make all values in averages positive
        for i in 0..<averages.count {
            if averages[i] < 0 {
                averages[i] = averages[i] * -1
            }
        }
        
        // Find which average is the greatest suggesting furthest from the preffered power profile
        let maxAverage = averages.max()!
        let maxAverageIndex = averages.firstIndex(of: maxAverage)!
        
        if maxAverageIndex == 0 {
            return "You should work on your Anerobic power."
        } else if maxAverageIndex == 1 {
            return "You should work on your Vo2 Max and Endurnace power"
        } else if maxAverageIndex == 2 {
            return "You should work on your Threshold, Tempo and Endurance Power"
        } else {
            return "Not enough data top suggest any training."
        }
    }
    
    private static func getValueWhere(x: Double, coefficients: [Double]) -> Double {
        var value: Double = 0
        for i in 0..<coefficients.count {
            value += coefficients[i] * pow(x, Double(i))
        }
        return value
    }
}
