//
//  TrainingZone.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import Foundation

class TrainingZone: Identifiable {
    var id: UUID
    var description: String
    var title: String
    var trainingPlans: [TrainingPlan]
    
    init(id: UUID = UUID(), description: String, title: String, trainingPlans: [TrainingPlan]) {
        self.id = id
        self.description = description
        self.title = title
        self.trainingPlans = trainingPlans
    }
}
