//
//  PowerChartView.swift
//  Watz
//
//  Created by Isaac Allport on 05/12/2024.
//

import SwiftUI
import Charts
import SwiftData

struct PowerChartView: View {
    var powerProfile: PowerProfile
    
    @Query(sort: \Effort.time) private var efforts: [Effort]
    
    let linearGradient = LinearGradient(gradient: Gradient(colors: [Color.accentColor.opacity(0.4), Color.accentColor.opacity(0)]), startPoint: .top, endPoint: .bottom)
    
    func evaluatePolynomial(at x: Double) -> Double {
        let reversedCoefficients = powerProfile.powerCoefficients.reversed() // Reverse the coefficients
        return reversedCoefficients.enumerated().reduce(0.0) { result, term in
            let (index, coefficient) = term
            return result + coefficient * pow(x, Double(reversedCoefficients.count - 1 - index))
        }
    }
    
    var dataPoints: [(x: Double, y: Double)] {
        let xValues = stride(from: 1.0, through: 3600.0, by: 10)
        return xValues.map { x in
            (x: x, y: evaluatePolynomial(at: x))
        }
    }
    
    var body: some View {
        Chart {
//            ForEach(dataPointsLong, id: \.x) { point in
//                LineMark(x: .value("X", point.x),
//                         y: .value("Y", point.y)
//                )
//                .foregroundStyle(.red)
//            }
//                
//            ForEach(dataPointsShort, id: \.x) { point in
//                LineMark(x: .value("X", point.x),
//                         y: .value("Y", point.y)
//                )
//                .foregroundStyle(.purple)
//            }
            
//            ForEach(dataPoints, id: \.x) { point in
//                LineMark(x: .value("x", point.x),
//                         y: .value("y", point.y)
//                )
//            }
//            ForEach(dataPoints, id: \.x) { point in
//                AreaMark(x: .value("x", point.x),
//                         y: .value("y", point.y)
//                )
//            }
//            .foregroundStyle(linearGradient)

            RuleMark(y: .value("Threshold", powerProfile.getThreshold()))
                .foregroundStyle(.green)
            
            ForEach(efforts) { effort in
                LineMark(x: .value("x", effort.time), y: .value("y", effort.power))
            }
            ForEach(efforts) { effort in
                AreaMark(x: .value("x", effort.time), y: .value("y", effort.power))
            }
            .foregroundStyle(linearGradient)
        }
            .chartYScale(domain: 0...1500) // Adjust the Y scale based on your data
            .chartXScale(domain: 0...1200)  // Adjust the X scale based on your range
            .chartYAxis(.hidden)
    }
}

#Preview {
    PowerChartView(powerProfile: PowerProfile(riderType: "Rouler", powerCoefficients: [1000,-20,-0.01], powers: [1200, 800, 500, 400]))
}
