//
//  IntervalView.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import SwiftUI

struct IntervalView: View {
    let trainingPlan: TrainingPlan
    
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Intensity")
                    Spacer()
                    Text("\(trainingPlan.intensity)")
                }
            }
            Section("Intervals") {
                ForEach(trainingPlan.intervals) { interval in
                    HStack {
                        Text("\(interval.targetPower(threshold: 300)) w")
                            .foregroundStyle(powerIntensityColor(interval.intensityLevel))
                        Spacer()
                        Text(timeFormatter(interval.duration))
                    }
                }
            }
        }
        .navigationTitle(trainingPlan.title)
    }
    
    func powerIntensityColor(_ intensity: Double) -> Color {
        // The value will range from 0 - 2.0 0.5 and under green, then orange 0.5 - 1.0 then red for above
        let color: Color
        if intensity <= 0.5 {
            color = .gray
        } else if intensity < 1.0 {
            color = .orange
        } else {
            color = .red
        }
        return color
    }
    
    func timeFormatter(_ time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    IntervalView(trainingPlan: trainingData[0].trainingPlans[0])
}
