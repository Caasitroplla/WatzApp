//
//  CriticalPower.swift
//  Watz
//
//  Created by Isaac Allport on 17/12/2024.
//

import Foundation

public class CriticalPower {
    var criticalPower: Double
    var wPrime: Double

    init(efforts: [Effort]) {
        self.criticalPower = 0.0
        self.wPrime = 0.0
        
        if efforts.isEmpty {
            return
        }
        
        var criticalPowerVals: [Double] = []
        var wPrimeVals: [Double] = []
        
        // Filter all efforts less than 180 seconds
        let filteredEfforts = efforts.filter { $0.time >= 180.0 }
        
        // Between every 2 possible pairs of efforts calculate CP and W' for those values then average
        for i in 0..<filteredEfforts.count {
            for j in (i+1)..<filteredEfforts.count {
                let result = calculateCPAndWPrime(firstEffort: filteredEfforts[i], secondEffort: filteredEfforts[j])
                criticalPowerVals.append(abs(result.0))
                wPrimeVals.append(abs(result.1))
            }
        }
        
        self.criticalPower = criticalPowerVals.max() ?? 300
        self.wPrime = wPrimeVals.max() ?? 20000
    }

    private func calculateCPAndWPrime(firstEffort: Effort, secondEffort: Effort) -> (Double, Double) {
        let totalTime = Double(firstEffort.time + secondEffort.time)
        let totalPowerNTime = (Double(firstEffort.time) * Double(firstEffort.power)) - (Double(secondEffort.time) * Double(secondEffort.power))
        let criticalPower = totalPowerNTime / totalTime
        let wPrime = (Double(secondEffort.power) - criticalPower) * Double(secondEffort.time)
        return (criticalPower, wPrime)
    }
    
    func estimatePowerFor(time: TimeInterval) -> Double {
        if time == 0.0 { return 0.0 }
        return (self.wPrime / time) + self.criticalPower
    }
    
    func estimateTimeAt(power: Double) -> Double {
        if power == 0.0 { return 0.0}
        return self.wPrime / (power - self.criticalPower)
    }
    
    func getPowerForComparisons() -> [Double] {
        return [
            estimatePowerFor(time: 5),
            estimatePowerFor(time: 60),
            estimatePowerFor(time: 300),
            estimatePowerFor(time: 3600),
        ]
    }
}
