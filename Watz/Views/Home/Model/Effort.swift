//
//  Effort.swift
//  Watz
//
//  Created by Isaac Allport on 04/12/2024.
//

import Foundation
import SwiftData

@Model
class Effort {
    var time: TimeInterval
    var power: Int
    
    init(time: TimeInterval, power: Int) {
        self.time = time
        self.power = power
    }
}
