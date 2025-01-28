//
//  PowerCategorisation.swift
//  Watz
//
//  Created by Isaac Allport on 13/11/2024.
//

import Foundation

// Gender - stored as 0 - Male, 1 - Female, 2 - Other (Male Values)


// Power Values normalised in W/Kg
let powerValuesMale = [
    [11.80, 13.44, 15.07, 16.97, 18.60, 20.23, 21.86],
    [6.33, 7.02, 7.71, 8.51, 9.2, 9.89, 10.58],
    [2.95, 3.57, 4.19, 4.91, 5.53, 6.15, 6.77],
    [2.40, 2.93, 3.47, 4.09, 4.62, 5.15, 5.69]
]

let powerValuesFemale = [
    [9.72, 11.01, 12.31, 13.82, 15.11, 16.40, 17.70],
    [5.21, 5.76, 6.30, 6.93, 7.48, 8.02, 8.56],
    [2.45, 3.00, 3.56, 4.20, 4.76, 5.31, 5.87],
    [1.99, 2.49, 2.98, 3.55, 4.05, 4.54, 5.03]
]



// Actual maths for next bit
func CategorisePower(power: Double, weight: Double, list: [Double]) -> String {
    let normalised = power / weight
    if normalised < list[0] {
        return PowerCategoryToText(category: 8)
    } else if normalised < list[1] {
        return PowerCategoryToText(category: 7)
    } else if normalised < list[2] {
        return PowerCategoryToText(category: 6)
    } else if normalised < list[3] {
        return PowerCategoryToText(category: 5)
    } else if normalised < list[4] {
        return PowerCategoryToText(category: 4)
    } else if normalised < list[5] {
        return PowerCategoryToText(category: 3)
    } else if normalised < list[6] {
        return PowerCategoryToText(category: 2)
    } else {
        return PowerCategoryToText(category: 1)
    }
}



// Categorise power functions
func Categorise5Second(power: Double, weight: Double, gender: Int) -> String {
    if gender == 1 {
        return CategorisePower(power: power, weight: weight, list: powerValuesFemale[0])
    }
    return CategorisePower(power: power, weight: weight, list: powerValuesMale[0])
}

func Categorise1Minute(power: Double, weight: Double, gender: Int) -> String {
    if gender == 1 {
        return CategorisePower(power: power, weight: weight, list: powerValuesFemale[1])
    }
    return CategorisePower(power: power, weight: weight, list: powerValuesMale[1])
}

func Categorise5Minute(power: Double, weight: Double, gender: Int) -> String {
    if gender == 1 {
        return CategorisePower(power: power, weight: weight, list: powerValuesFemale[2])
    }
    return CategorisePower(power: power, weight: weight, list: powerValuesMale[2])
}

func Categorise60Minute(power: Double, weight: Double, gender: Int) -> String {
    if gender == 1 {
        return CategorisePower(power: power, weight: weight, list: powerValuesFemale[3])
    }
    return CategorisePower(power: power, weight: weight, list: powerValuesMale[3])
}



// Actual maths for next bit
func PowerToLevelUp(power: Double, weight: Double, list: [Double]) -> Double {
    let normalised = power / weight
    if normalised < list[0] {
        return (list[0] - normalised) * weight
    } else if normalised < list[1] {
        return (list[1] - normalised) * weight
    } else if normalised < list[2] {
        return (list[2] - normalised) * weight
    } else if normalised < list[3] {
        return (list[3] - normalised) * weight
    } else if normalised < list[4] {
        return (list[4] - normalised) * weight
    } else if normalised < list[5] {
        return (list[5] - normalised) * weight
    } else {
        return 0
    }
}



// Power needed to reach top and bottom of each bound
func PowerToLevelUp5Second(power: Double, weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[0]))
    }
    return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[0]))
}

func PowerToLevelDown5Second(power: Double,weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int( (1.33 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[0]) ) )
    }
    return Int( (1.68 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[0]) ) )
}



func PowerToLevelUp1Minute(power: Double, weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[1]))
    }
    return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[1]))
}

func PowerToLevelDown1Minute(power: Double,weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int( (0.56 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[1]) ) )
    }
    return Int( (0.71 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[1]) ) )
}



func PowerToLevelUp5Minute(power: Double, weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[2]))
    }
    return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[2]))
}

func PowerToLevelDown5Minute(power: Double,weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int( (0.57 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[2]) ) )
    }
    return Int( (0.64 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[2]) ) )
}



func PowerToLevelUp60Minute(power: Double, weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesFemale[3]))
    }
    return Int(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[3]))
}

func PowerToLevelDown60Minute(power: Double,weight: Double, gender: Int) -> Int {
    if gender == 1 {
        return Int( (0.51 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[3]) ) )
    }
    return Int( (0.55 * weight) - Double(PowerToLevelUp(power: power, weight: weight, list: powerValuesMale[3]) ) )
}



// Gets the name of the class
func PowerCategoryToText(category: Int) -> String {
    switch category {
    case 1:
        return "World Class"
    case 2:
        return "Exceptional"
    case 3:
        return "Cat 1"
    case 4:
        return "Cat 2"
    case 5:
        return "Cat 3"
    case 6:
        return "Cat 4"
    case 7:
        return "Cat 5"
    case 8:
        return "Untrained"
    default:
        return "Error"
    }
}



// Gets the next power category
func NextPowerCategory(category: String) -> String {
    switch category {
    case "World Class":
        return ""
    case "Exceptional":
        return "World Class"
    case "Cat 1":
        return "Exceptional"
    case "Cat 2":
        return "Cat 1"
    case "Cat 3":
        return "Cat 2"
    case "Cat 4":
        return "Cat 3"
    case "Cat 5":
        return "Cat 4"
    case "Untrained":
        return "Cat 5"
    default:
        return "Error"
    }
}


