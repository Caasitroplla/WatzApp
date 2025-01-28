//
//  EffortPreviewer.swift
//  Watz
//
//  Created by Isaac Allport on 04/12/2024.
//

import Foundation
import SwiftData

@MainActor
struct EffortPreviewer {
    let container: ModelContainer
    let effort: Effort
    
    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Effort.self, configurations: config)
        
        effort = Effort(time: 60.0, power: 800)
        
        container.mainContext.insert(effort)
    }
}
