//
//  NewDataItemView.swift
//  Watz
//
//  Created by Isaac Allport on 07/12/2024.
//

import SwiftUI

struct NewDataItemView: View {
    enum FocusedField {
        case newEffortTime, newEffortPower
    }
    
    @FocusState private var focusedField: FocusedField?
    @Binding var newEffortTime: TimeInterval
    @Binding var newEffortPower: Int
    
    var body: some View {
        Form {
            Section("Time") {
                TextField("Time", value: $newEffortTime, format: .number)
                    .focused($focusedField, equals: .newEffortTime)
                    .keyboardType(.numberPad)
                    .submitLabel(.continue)
            }
            Section("Power") {
                TextField("Power", value: $newEffortPower, format: .number)
                    .focused($focusedField, equals: .newEffortPower)
                    .keyboardType(.numberPad)
                    .submitLabel(.done)
            }
            
            Section {
                Text("Enter time in seconds and power in watts. These must be maximal efforts")
                    .font(.caption)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                    )
            }
        }
        .defaultFocus($focusedField, .newEffortTime)
        .onAppear {
            focusedField = .newEffortTime
        }
        .onSubmit {
            if focusedField == .newEffortTime {
                focusedField = .newEffortPower
            } else {
                focusedField = nil
            }
        }
    }
}

#Preview {
    NewDataItemView(newEffortTime: .constant(10.0), newEffortPower: .constant(10))
}
