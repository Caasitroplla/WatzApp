//
//  TrainingPlan.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import Foundation

class TrainingPlan: Identifiable {
    var id: UUID
    var title: String
    var intensity: Int
    var intervals: [TrainingInterval]
    
    init(id: UUID = UUID(), title: String, intensity: Int, intervals: [TrainingInterval]) {
        self.id = id
        self.title = title
        self.intensity = intensity
        self.intervals = intervals
    }
    
    public func duration() -> TimeInterval {
        var totalDuration: TimeInterval = 0.0
        for interval in self.intervals {
            totalDuration += interval.duration
        }
        return totalDuration
    }
}
