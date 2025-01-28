//
//  TrainingPlanView.swift
//  Watz
//
//  Created by Isaac Allport on 28/11/2024.
//

import SwiftUI

struct TrainingPlanView: View {
    let trainingPlan: TrainingZone
    
    var body: some View {
        List {
            Section {
                Text(trainingPlan.description)
            }
            ForEach(trainingPlan.trainingPlans) { plan in
                NavigationLink(destination: IntervalView(trainingPlan: plan), label: {
                    HStack {
                        Text(plan.title)
                        Spacer()
                        Text(timeFormatter(getDurationForInterval(plan: plan)))
                    }
                })
            }
        }
        .navigationTitle(trainingPlan.title)
    }
    
    func getDurationForInterval(plan: TrainingPlan) -> TimeInterval {
        // Find interval in list
        let interval = trainingPlan.trainingPlans.first { $0.id == plan.id }
        // Retrun the duration of that interval
        let duration = interval?.duration() ?? 0
        return duration
    }
    
    func timeFormatter(_ timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval / 3600)
        let minutes = Int((timeInterval.truncatingRemainder(dividingBy: 3600)) / 60)
        return String(format: "%02d:%02d", hours, minutes)
    }
    
}

#Preview {
    TrainingPlanView(trainingPlan: trainingData[1])
}
