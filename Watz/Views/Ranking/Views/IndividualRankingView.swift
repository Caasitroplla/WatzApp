//
//  IndividualRankingView.swift
//  Watz
//
//  Created by Isaac Allport on 13/11/2024.
//

import SwiftUI

struct IndividualRankingView: View {
    
    var power: Int
    var level: String
    var powerToNextLevel: Int
    var powerToLastLevel: Int
    var title: String
    
    @AppStorage("userWeight") var weight: Double = 70
    
    private func wattsper (power: Int) -> Double {
        return round((Double(power) / weight) * 10) / 10
    }
    
    func nextLevel () -> String {
        return NextPowerCategory(category: level)
    }
    
    var body: some View {
        List {
            Section {
                Text(String(power))
                    .font(.system(size: 98))
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                    )
                    .listRowSeparator(.hidden)
                
                Text("Watts")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.clear)
                    )
            }
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(Color.gray)
                        .opacity(0.3)
                        .frame(width: 345.0, height: 8.0)
                    Rectangle()
                        .foregroundColor(Color.blue)
                        .frame(width: max(345 * ( Double(powerToLastLevel) / (Double(powerToLastLevel) + Double(powerToNextLevel))), 8.0 ), height: 8.0)
                    
                }
                .cornerRadius(4.0)
                HStack {
                    Text(level)
                        
                    Spacer()
                    Text(nextLevel())
                }
                .foregroundStyle(.secondary)
            }
            .listRowSeparator(.hidden)
            
            .listRowBackground(
                RoundedRectangle(cornerRadius: 5)
                    .fill(.clear)
            )
            
            Section("Stats") {
                HStack {
                    Text("Current Level")
                    Spacer()
                    Text(level)
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Watts Per Kg")
                    Spacer()
                    Text("\(String(wattsper(power: power))) W/Kg")
                        .fontWeight(.bold)
                }
            }
            
            Section("Improve") {
                HStack {
                    Text("Next Level")
                    Spacer()
                    Text(nextLevel())
                        .fontWeight(.bold)
                }
                HStack {
                    Text("Power Needed")
                    Spacer()
                    Text("+\(String(powerToNextLevel)) W")
                        .fontWeight(.bold)
                }
                HStack {
                    Text("W Per Kg Needed")
                    Spacer()
                    Text("+\(String(wattsper(power: powerToNextLevel))) W/Kg")
                        .fontWeight(.bold)
                }
                
            }
        }
        .listRowSpacing(0)
        .navigationTitle(title)
    }
}

#Preview {
    NavigationView {
        IndividualRankingView(power: 350, level: "Cat 1", powerToNextLevel: 50, powerToLastLevel: 50, title: "5 Seconds")
    }
}
