//
//  StatsView.swift
//  Watz
//
//  Created by Isaac Allport on 05/12/2024.
//

import SwiftUI

struct StatsView: View {
    @State var Vo2: Double
    @State var threshold: Int
    @AppStorage("userWeight") private var weight: Double = 70
    
    var body: some View {
        // Should show Vo2, Threshold and in WpKG, and weight
        List {
            Section("Threshold") {
                Text("\(threshold)w")
                    .font(.system(size: 80))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("\(String(relativePower())) w/kg")
                    .font(.system(size: 20))
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            Section ("Vo2 Max") {
                Text("\(String((Vo2 * 10).rounded() / 10))")
                    .font(.system(size: 40))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("ml/kg/min")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            Section("Weight") {
                Text("\(String(weight)) kg")
                    .font(.system(size: 40))
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .listRowSeparator(.hidden)
    }
    
    private func relativePower() -> Double {
        return round((Double(threshold) / weight) * 100) / 100
    }
}

#Preview {
    StatsView(Vo2: 60.2, threshold: 340)
}
