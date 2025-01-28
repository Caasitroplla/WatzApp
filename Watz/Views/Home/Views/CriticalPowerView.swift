//
//  CriticalPowerView.swift
//  Watz
//
//  Created by Isaac Allport on 17/12/2024.
//

import SwiftUI

struct CriticalPowerView: View {
    
    var criticalPower: CriticalPower
    
    @State private var time: Double = 0.0
    @State private var power: Double = 0.0
    
    @State private var predictedPower: Double = 0.0
    @State private var predictedTime: Double = 0.0
    
    @FocusState private var powerFocused: Bool
    @FocusState private var timeFocused: Bool
    
    var body: some View {
        List {
            Section {
                Text("\(Int(criticalPower.criticalPower))w")
                    .font(.system(size: 80))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                HStack {
                    Text("\(Int(criticalPower.wPrime))j W Prime")
                    Spacer()
                    Text("Critical Power")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            // Power Prediction part
            Section("Predict Power") {
                TextField("Time Interval",value: $time, format: .number)
                    .keyboardType(.numberPad)
                    .focused($powerFocused)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Calculate") {
                                powerFocused = false
                                timeFocused = false
                                predictedPower = criticalPower.estimatePowerFor(time: time)
                                predictedTime = criticalPower.estimateTimeAt(power: power)
                            }
                        }
                    }
                HStack {
                    Text("Predicted Power")
                    Spacer()
                    Text("\(Int(predictedPower))w")
                }
                
            }
            Section("Predict Time") {
                TextField("Power Intensity", value: $power, format: .number)
                    .keyboardType(.numberPad)
                    .focused($timeFocused)
                HStack {
                    Text("Predicted Time")
                    Spacer()
                    Text("\(Int(predictedTime))s")
                }
            }
            
            Text("These predictions are only accurate for values between 180 seconds and 60 mintes.")
                .background(Color(.clear))
        }
    }
}

#Preview {
    CriticalPowerView(criticalPower: CriticalPower(efforts: [Effort(time: 180, power: 500), Effort(time: 600, power: 400)]))
}
