//
//  ContentView.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("userWeight") private var weight: Double = 70.0
    @AppStorage("desiredRiderType") var desiredRiderType: String = "All Rounder"
    
    @Query private var efforts: [Effort]
    
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                let powerProfile = calculateUserProfile()
                if powerProfile == nil {
                    ContentUnavailableView {
                        Label("No efforts", systemImage: "house.fill")
                    } description: {
                        Text("You haven't logged any efforts so we are unable to calculate your power profile.")
                    }
                } else {
                    HomeView(powerProfile: powerProfile!, criticalPower: CriticalPower(efforts: efforts))
                }
            }
            
            Tab("Efforts", systemImage: "list.dash") {
                DataEntryView()
                
            }
            
            Tab("Ranking", systemImage: "trophy.fill") {
                let powerProfile = calculateUserProfile()
                if powerProfile == nil {
                    ContentUnavailableView {
                        Label("No efforts", systemImage: "house.fill")
                    } description: {
                        Text("You haven't logged any efforts so we are unable to calculate your power profile.")
                    }
                } else {
                    RankingView(seconds5: Int(powerProfile!.powers[0]), minutes1: Int(powerProfile!.powers[1]), minutes5: Int(powerProfile!.powers[2]), threshold: Int(powerProfile!.powers[3]))
                }
                
                
            }
            
            Tab("Training", systemImage: "calendar"){
                let powerProfile = calculateUserProfile()
                let trainingSuggestion = TrainingSuggestionAlgorithm.suggestTraining(powerProfile: powerProfile, riderType: desiredRiderType)
                TrainingView(trainingSuggestion: trainingSuggestion)
            }
            
            Tab("General", systemImage: "gear") {
                SettingView()
                
            }
        }
        
        
    }
    
    private func calculateUserProfile() -> PowerProfile? {
        if efforts.count == 0 { return nil } // If there is no data to process no processing shall be done
        
        let newPowerProfile = PowerProfile(riderType: "", powerCoefficients: [], powers: [])
        
        // Put efforts into the CGPoint array ready for processing
        var points: [CGPoint] = []
        
        // Filter, removing all points greater than 3600
        efforts.filter { $0.time < 3600 }.forEach { effort in
            let point = CGPoint(x: Double(effort.time), y: Double(effort.power))
            points.append(point)
        }
        
        // Also add efforts in a mirror line around 1 hour for the quadratic curve
        efforts.forEach { effort in
            let point = CGPoint(x: Double(7200 - effort.time), y: Double(effort.power))
            points.append(point)
        }
        
        newPowerProfile.powerCoefficients = PolynomialRegression.regression(withPoints: points, degree: 2) ?? []
        
        // Calculate the power at the following intervals then calculate the rider category using CP
        let criticalPower = CriticalPower(efforts: efforts)
        
        newPowerProfile.powers = criticalPower.getPowerForComparisons()
        
        // See if they're are any efforts that have the following time intervals 5, 60, 300, 3600
        if let matchingEffort = efforts.first(where: { $0.time == 5.0}) {
            newPowerProfile.powers[0] = Double(matchingEffort.power)
        }
        
        if let matchingEffort = efforts.first(where: { $0.time == 60.0}) {
            newPowerProfile.powers[1] = Double(matchingEffort.power)
        }
        
        if let matchingEffort = efforts.first(where: { $0.time == 300.0}) {
            newPowerProfile.powers[2] = Double(matchingEffort.power)
        }
        
        if let matchingEffort = efforts.first(where: { $0.time == 3600.0}) {
            newPowerProfile.powers[3] = Double(matchingEffort.power)
        }
        
        newPowerProfile.riderType = RiderCategorisation.categorise(weight: weight, power: newPowerProfile.powers)
        
        return newPowerProfile
    }
    
    private func predictPower(coefficients: [Double], time: TimeInterval) -> Double {
        var y: Double = 0.0
        for (index, coefficient) in coefficients.enumerated() {
            y += coefficient * pow(Double(time), Double(index))
        }
        return y
    }
}

#Preview {
    ContentView()
}
