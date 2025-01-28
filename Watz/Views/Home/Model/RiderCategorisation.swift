//
//  RiderCategorisation.swift
//  Watz
//
//  Created by Isaac Allport on 03/12/2024.
//

import Foundation

public class RiderCategorisation {
    public static func categorise(weight: Double, power: [Double]) -> String {
        let riderTypes = ["Sprinter", "Puncher", "All Rounder", "Time Trialist", "Climber"]
        
        // Power intervals stored as [5 second, 1 minute, 5 minute, 60 minute]
        
        // Check to make sure power array has 4 elements
        if power.count != 4 {
            fatalError("Rider categorisation algorithm expects power array to have 4 elements")
        }
        
        if power[1] > 1.2 * power[3] {
            if power[0] > 4 * power[3] {
                return riderTypes[0]
            } else {
                if power[1] > 2 * power[2] {
                    return riderTypes[1]
                } else {
                    return riderTypes[2]
                }
            }
        } else {
            if weight > 77 {
                return riderTypes[3]
            } else {
                return riderTypes[4]
            }
        }
    }
}
