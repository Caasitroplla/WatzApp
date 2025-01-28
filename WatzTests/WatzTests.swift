//
//  WatzTests.swift
//  WatzTests
//
//  Created by Isaac Allport on 24/01/2025.
//

import Testing
import Foundation
@testable import Watz


struct PowerProfileTests {
    let powerProfile = PowerProfile(riderType: "All Rounder", powerCoefficients: [1, 1, 1], powers: [1000, 600, 400, 350])
    
    @Test("Initalisation") func initialisation() {
        #expect(powerProfile.riderType == "All Rounder")
        #expect(powerProfile.powerCoefficients == [1, 1, 1])
        #expect(powerProfile.powers == [1000, 600, 400, 350])
    }
    
    @Test("Getting Coefficients") func getCoefficients() {
        #expect(powerProfile.getPowerCoefficients() == [1, 1, 1])
    }
    
    @Test("Getting Threshold") func getThreshold() {
        #expect(powerProfile.getThreshold() == 350)
    }
    
    @Test("Threshold Default Value") func checkDefaultValues() {
        powerProfile.powers = []
        #expect(powerProfile.getThreshold() == 300)
    }
    
    @Test("Power Prediction") func checkPowerPrediction() {
        #expect(powerProfile.predictPower(time: 10.0) == 111.0)
    }
}


struct PowerZoneCalculatorTests {
    @Test("Power Zone Calculation") func checkPowerZoneCalculation() {
        let powerProfile = PowerProfile(riderType: "Climber", powerCoefficients: [ 3.7223-05, -0.268, 697.302], powers: [1011, 580, 363, 302])
        #expect(PowerZoneCalculator.getPowerZones(powerProfile: powerProfile).first! == [0, 166])
    }
    
    @Test("Nil Profile Given") func checkNoProfileGiven() {
        let powerProfile: PowerProfile? = nil
        #expect(PowerZoneCalculator.getPowerZones(powerProfile: powerProfile) == [[0, 150], [151, 231], [232, 321], [322, 350], [350, 450], [451, 999]])
    }
}


struct RiderCategorisationTests {
    let weights: [Double] = [60, 69, 82, 83]
    let powers: [[Double]] = [[1011, 580, 363, 302], [1104, 704, 425, 330], [1980, 1034, 502, 375], [1980, 1034, 502, 375], [1703, 934, 645, 474]]
    let expected = ["All Rounder", "All Rounder", "Sprinter", "Sprinter"]
    
    @Test("Rider Categorisation") func checkRiderCategorisation() {
        for (index, weights) in weights.enumerated() {
            let result = RiderCategorisation.categorise(weight: weights, power: powers[index])
            #expect(result == expected[index])
        }
    }
}


struct RiderVo2MaxCalculatorTests {
    @Test("Vo2 Max Calculation") func checkVo2MaxCalculation() {
        #expect(RiderVo2Estimation.estimate(power: 500, weight: 80) == 72.0375)
    }
}


struct PolynomialRegressionTests {
    let points: [CGPoint] = [CGPoint(x: 1,y: 1), CGPoint(x: 2, y: 3), CGPoint(x: 3,y: 5)]
    
    @Test("1 st Degree Polynomial", .timeLimit(.minutes(1))) func checkFirstDegreePolynomial() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 1)
        #expect(regression == [-0.9999999999999999, 2.0])
    }
    
    @Test("2 nd Degree Polynomial", .timeLimit(.minutes(1))) func checkSecondDegreePolynomial() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 2)
        #expect(regression == [-1.0000000000000102, 2.0000000000000147, -4.010095687161363e-15])
    }
    
    @Test("3 rd Degree Polynomial", .timeLimit(.minutes(1))) func checkThirdDegreePolynomial() {
        let regression = PolynomialRegression.regression(withPoints: points, degree: 3)
        #expect(regression == [-0.6122698909572626, 1.2891614667550535, 0.38773010904266036, -0.06462168484043827])
    }
}


struct PowerCategorisationTests {
    @Test("5 second female") func check5SecondFemale() {
        #expect(Categorise5Second(power: 1700, weight: 60.0, gender: 1) == "World Class")
    }
    
    @Test("60 minute male") func check60MinuteMale() {
        #expect(Categorise60Minute(power: 200, weight: 100.0, gender: 0) == "Untrained")
    }
}


struct TrainingSuggestionAlgorithmTests {
    let powerProfile = PowerProfile(riderType: "All Rounder", powerCoefficients: [1, 1, 1], powers: [1000, 600, 400, 350])
    
    @Test("Training Suggestion Algorithm Test") func trainingSuggestionAlgorithmTest() {
        #expect(TrainingSuggestionAlgorithm.suggestTraining(powerProfile: powerProfile, riderType: "All Rounder") == "You should work on your Anerobic power.")
    }
}
