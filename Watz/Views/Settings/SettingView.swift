//
//  SettingView.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI

struct SettingView: View {
    
    @AppStorage("selectedAppearance") var selectedApperance = 0
    @AppStorage("userWeight") var weight: Double = 70
    @AppStorage("userGender") var gender: Int = 0
    @AppStorage("userBirthDate") var birthDate: Date = Date.now
    @AppStorage("desiredRiderType") var desiredRiderType: String = "All Rounder"
    
    @FocusState private var isInputActive : Bool
    
    let formatter: Formatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            Form {
                LabeledContent("Version", value: "0.1")
                
                Picker("Color Scheme", selection: $selectedApperance) {
                    Text("Default System")
                        .tag(0)
                    Text("Light")
                        .tag(1)
                    Text("Dark")
                        .tag(2)
                }
                .pickerStyle(.inline)
                
                Section("Athelte Information") {
                    // Birthday
                    DatePicker(selection: $birthDate, in: ...Date.now, displayedComponents: .date) {
                        Text("Date of Birth")
                    }
                    
                    // Gender
                    Picker("Gender", selection: $gender) {
                        Text("Male")
                            .tag(0)
                        Text("Female")
                            .tag(1)
                        Text("Non-Binary")
                            .tag(2)
                        Text("Prefer Not To Say")
                            .tag(3)
                    }
                    
                    // Weight
                    HStack {
                        Text("Weight (kg)")
                        Spacer()
                        TextField("Weight", value: $weight, formatter: formatter)
                            .keyboardType(.numberPad)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .multilineTextAlignment(.trailing)
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    
                                    Button("Done") {
                                        isInputActive = false
                                    }
                                }
                            }
                    }
                    
                    // Preferred Rider Type
                    Picker("Preferred Rider Type", selection: $desiredRiderType) {
                        Text("All Rounder")
                        Text("Climber")
                        Text("Puncher")
                        Text("Sprinter")
                        Text("Time Trialist")
                    }
                }
                Section {
                    NavigationLink(destination: HelpView()) {
                        Label("Help", systemImage: "questionmark.circle")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    
    SettingView()
    
}
