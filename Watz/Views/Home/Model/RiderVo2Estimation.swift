//
//  RiderVo2Estimation.swift
//  Watz
//
//  Created by Isaac Allport on 03/12/2024.
//

import Foundation

public class RiderVo2Estimation {
    public static func estimate(power: Double, weight: Double) -> Double{
        return 16.6 + (8.87 * (power / weight))
    }
}
