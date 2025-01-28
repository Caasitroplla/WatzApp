//
//  TrainingData.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import Foundation

let trainingData: [TrainingZone] = [
    TrainingZone(description: "This is zone is trained to build up your aerobic base. This is carried out at an low intensity.", title: "Endurance", trainingPlans: [
        TrainingPlan(title: "Base Endurance", intensity: 3, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 1800, intensityLevel: 0.65),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ]),
        TrainingPlan(title: "Base Endurance", intensity: 3, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 5400, intensityLevel: 0.65),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ]),
        TrainingPlan(title: "Base Endurance", intensity: 3, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 9000, intensityLevel: 0.65),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ]),
        TrainingPlan(title: "Base Endurance", intensity: 3, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 12600, intensityLevel: 0.65),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ]),
        TrainingPlan(title: "Base Endurance", intensity: 3, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 16200, intensityLevel: 0.65),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ])
    ]),
    TrainingZone(description: "Tempo is still primarilry aerobic, but starts to become challanging to sustain over long periods as it adds some musclar endurance demands.", title: "Tempo", trainingPlans: [
        TrainingPlan(title: "2 by 20", intensity: 7, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 1200, intensityLevel: 0.825),
            TrainingInterval(duration: 600, intensityLevel: 0.5),
            TrainingInterval(duration: 1200, intensityLevel: 0.825),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ])
    ]),
    TrainingZone(description: "Your threshold is the point at which your body switches from aerobic to anerobic metabolism.", title: "Threshold", trainingPlans: [
        TrainingPlan(title: "12 Minute Repeats", intensity: 9, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 720, intensityLevel: 1),
            TrainingInterval(duration: 360, intensityLevel: 0.5),
            TrainingInterval(duration: 720, intensityLevel: 1),
            TrainingInterval(duration: 360, intensityLevel: 0.5),
            TrainingInterval(duration: 720, intensityLevel: 1),
            TrainingInterval(duration: 360, intensityLevel: 0.5),
            TrainingInterval(duration: 720, intensityLevel: 1),
            TrainingInterval(duration: 360, intensityLevel: 0.5),
            TrainingInterval(duration: 720, intensityLevel: 1),
            TrainingInterval(duration: 360, intensityLevel: 0.5),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ])
    ]),
    TrainingZone(description: "", title: "Vo2 Max", trainingPlans: []),
    TrainingZone(description: "This is the highest level of intensity, power is generate through anaerobic metabolism. These efforts are higher-force abd hsorter duration, activating energy systems that can only be sustained for minutes, at most.", title: "Anerobic", trainingPlans: [
        TrainingPlan(title: "25 second repeats", intensity: 10, intervals: [
            TrainingInterval(duration: 1200, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 180, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 25, intensityLevel: 2.0),
            TrainingInterval(duration: 155, intensityLevel: 0.5),
            TrainingInterval(duration: 600, intensityLevel: 0.5)
        ])
    ])
]
