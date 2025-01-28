//
//  Interval.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import Foundation

class TrainingInterval: Identifiable {
    var id: UUID
    var duration: TimeInterval
    var intensityLevel: Double
    
    init(id: UUID = UUID(), duration: TimeInterval, intensityLevel: Double) {
        self.id = id
        self.duration = duration
        self.intensityLevel = intensityLevel
    }
    
    func targetPower(threshold: Int) -> Int {
        return Int(intensityLevel * Double(threshold))
    }
}
