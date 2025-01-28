//
//  TrainingView.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI

struct TrainingView: View {
    
    var trainingSuggestion: String
    
    var body: some View {
        NavigationView {
            List {
                
                // Current Tip
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                    Text(trainingSuggestion)
                        .font(.headline)
                }
                .listRowSeparator(.hidden)
                .foregroundStyle(.white)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.blue)
                        .padding(
                            EdgeInsets(
                                top: 2,
                                leading: 10,
                                bottom: 2,
                                trailing: 10
                            )
                        )
                )
                
                // Workout library
                Section("Workouts") {
                    ForEach(trainingData) { trainingPlan in
                        NavigationLink(destination: TrainingPlanView(trainingPlan: trainingPlan)) {
                            Text(trainingPlan.title)
                        }
                    }
                }
                
                
                // Cautionary statement
                Text("This is a training suggestion, this does not mean you need to follow the guidence directly. Varying your workouts will make you a more well rounded athelete.")
                    .foregroundStyle(.secondary)
                    .font(.caption2)
                    .listRowSeparator(.hidden)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                            .padding(
                                EdgeInsets(
                                    top: 10,
                                    leading: 10,
                                    bottom: 2,
                                    trailing: 10
                                )
                            )
                    )
            }
            .navigationTitle("Training")
        }
    }
}

#Preview {
    
    TrainingView(trainingSuggestion: "You should traing your threshold")
    
}
