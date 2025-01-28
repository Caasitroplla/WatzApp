//
//  PowerProfile.swift
//  Watz
//
//  Created by Isaac Allport on 04/12/2024.
//

import Foundation

public class PowerProfile {
    var creationDate: Date
    var riderType: String
    var powerCoefficients: [Double]
    var powers: [Double]
    
    init(creationDate: Date = Date.now, riderType: String, powerCoefficients: [Double], powers: [Double]) {
        self.creationDate = creationDate
        self.riderType = riderType
        self.powerCoefficients = powerCoefficients
        self.powers = powers
    }
    
    func getPowerCoefficients() -> [Double] {
        return self.powerCoefficients
    }
    
    func getThreshold() -> Int {
        return Int(powers.last ?? 300)
    }
    
    func predictPower(time: TimeInterval) -> Double {
        var value: Double = 0.0
        for i in 0..<powerCoefficients.count {
            value += powerCoefficients[i] * pow(time, Double(i))
        }
        return value
    }
}
