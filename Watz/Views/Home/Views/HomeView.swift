//
//  HomeView.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI
import Charts
import SwiftData

struct HomeView: View {
    @AppStorage("userWeight") private var weight: Double = 70
    
    var powerProfile: PowerProfile
    var criticalPower: CriticalPower
    
    var body: some View {
        NavigationView {
            List {
                // Stats View
                NavigationLink(destination: {
                    StatsView(Vo2: RiderVo2Estimation.estimate(power: Double(criticalPower.estimatePowerFor(time: 300)), weight: weight), threshold: Int(powerProfile.getThreshold()))
                        .navigationTitle("Stats")
                }, label: {
                    VStack {
                        HStack {
                            Label("Threshold", systemImage: "powermeter")
                            Spacer()
                            Text("\(powerProfile.getThreshold())w")
                                .bold()
                        }
                        HStack {
                            Text("\(String(weight))kg")
                            Spacer()
                            Text("\(String(relativePower()))w/kg")
                        }
                        .bold()
                        .padding(EdgeInsets(top: 3, leading: 0, bottom: 0, trailing: 0))
                    }
                })
                    .padding(7)
                    .foregroundStyle(.white)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.blue)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    )
                
                // Power Zones View
                PowerZoneView(powerZones: PowerZoneCalculator.getPowerZones(powerProfile: powerProfile))
                
                NavigationLink(destination: CriticalPowerView(criticalPower: criticalPower), label: {
                    HStack {
                        Label("Critical Power", systemImage: "bolt.fill")
                        Spacer()
                        Text("\(Int(self.criticalPower.criticalPower))w")
                            .bold()
                    }
                })
                .padding(7)
                .foregroundStyle(.white)
                .listRowBackground(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.blue)
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                )
                
                // Chart view
                PowerChartView(powerProfile: powerProfile)
                
                // Rider Classification View
                HStack {
                    Label("Rider Type", systemImage: "figure.outdoor.cycle")
                    Spacer()
                    Text(powerProfile.riderType)
                        .bold()
                }
                    .padding(7)
                    .foregroundStyle(.white)
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.blue)
                            .padding(EdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0))
                    )
            }
            .listRowSpacing(8)
            .navigationTitle("Home")
        }
    }
    
    private func relativePower() -> Double {
        return round((Double(powerProfile.getThreshold()) / weight) * 100) / 100
    }
}

#Preview {
    HomeView(powerProfile: PowerProfile(riderType: "Rouler", powerCoefficients: [1], powers: [1200, 800, 500, 400]), criticalPower: CriticalPower(efforts: [Effort(time: 180, power: 500), Effort(time: 600, power: 400)]))
    
}
