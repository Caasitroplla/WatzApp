//
//  RankingView.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI

struct RankingView: View {
    
    @State var dataType: Bool = false // false = just power
    
    @State var seconds5: Int
    @State var minutes1: Int
    @State var minutes5: Int
    @State var threshold: Int
    
    @AppStorage("userWeight") var weight: Double = 70
    @AppStorage("userGender") var gender: Int = 1
    
    private func withinRange(val: Int, max: Int) -> Int {
        if val >= max {
            return max
        }
        return val
    }
    
    func displayPower(power: Int, max: Int) -> String {
        let adjustedPower = withinRange(val: power, max: max)
        if dataType {
            let wattsper = round((Double(adjustedPower) / weight) * 10) / 10
           return "\(String(wattsper)) W/Kg"
        } else {
            // Display W
            return "\(String(adjustedPower)) W"
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Duration")
                        .frame(width: 69)
                    Spacer()
                    Text("Power")
                        .frame(width: 50)
                    Spacer()
                    Text("Percentile")
                        .frame(width: 140)
                }
                .font(.headline)
                .listRowSeparator(.hidden)
                
                // TODO: Link to propper page
                NavigationLink(destination: IndividualRankingView(
                    power: seconds5,
                    level: Categorise5Second(power: Double(seconds5), weight: weight, gender: gender),
                    powerToNextLevel: PowerToLevelUp5Second(power: Double(seconds5), weight: weight, gender: gender),
                    powerToLastLevel: PowerToLevelDown5Second(power: Double(seconds5), weight: weight, gender: gender),
                    title: "5 Second Power")){
                    VStack {
                        HStack {
                            Text("5 sec")
                                .font(.headline)
                                .frame(width: 60)
                            Spacer()
                            Text(displayPower(power: seconds5, max: 2500))
                            Spacer()
                            Text(Categorise5Second(power: Double(seconds5), weight: weight, gender: gender))
                                .frame(width: 100)
                        }
                    }
                }
                
                NavigationLink(destination: IndividualRankingView(
                    power: minutes1,
                    level: Categorise1Minute(power: Double(minutes1), weight: weight, gender: gender),
                    powerToNextLevel: PowerToLevelUp1Minute(power: Double(minutes1), weight: weight, gender: gender),
                    powerToLastLevel: PowerToLevelDown1Minute(power: Double(minutes1), weight: weight, gender: gender),
                    title: "1 Minute Power")){
                    VStack {
                        HStack {
                            Text("1 min")
                                .font(.headline)
                                .frame(width: 60)
                            Spacer()
                            Text(displayPower(power: minutes1, max: 1200))
                            Spacer()
                            Text(Categorise1Minute(power: Double(minutes1), weight: weight, gender: gender))
                                .frame(width: 100)
                        }
                    }
                }
                
                NavigationLink(destination: IndividualRankingView(
                    power: minutes5,
                    level: Categorise5Minute(power: Double(minutes5), weight: weight, gender: gender),
                    powerToNextLevel: PowerToLevelUp5Minute(power: Double(minutes5), weight: weight, gender: gender),
                    powerToLastLevel: PowerToLevelDown5Minute(power: Double(minutes5), weight: weight, gender: gender),
                    title: "5 Minute Power")){
                    VStack {
                        HStack {
                            Text("5 min")
                                .font(.headline)
                                .frame(width: 60)
                            Spacer()
                            Text(displayPower(power: minutes5, max: 600))
                            Spacer()
                            Text(Categorise5Minute(power: Double(minutes5), weight: weight, gender: gender))
                                .frame(width: 100)
                        }
                    }
                }
                
                NavigationLink(destination: IndividualRankingView(
                    power: threshold,
                    level: Categorise60Minute(power: Double(threshold), weight: weight, gender: gender),
                    powerToNextLevel: PowerToLevelUp60Minute(power: Double(threshold), weight: weight, gender: gender),
                    powerToLastLevel: PowerToLevelDown60Minute(power: Double(threshold), weight: weight, gender: gender),
                    title: "Threshold PowerPower")){
                    VStack {
                        HStack {
                            Text("60 min")
                                .font(.headline)
                                .frame(width: 60)
                            Spacer()
                            Text(displayPower(power: threshold, max: 500))
                            Spacer()
                            Text(Categorise60Minute(power: Double(threshold), weight: weight, gender: gender))
                                .frame(width: 100)
                        }
                    }
                }
                
            }
            .navigationTitle("Stack Up")
            .toolbar {
                ToolbarItem(placement: .primaryAction, content: {
                    Button(action: {
                        dataType.toggle()
                    }) {
                        Image(systemName: "powermeter")
                    }
                })
            }
        }
    }
    
    
}

#Preview {
    RankingView(seconds5: 900, minutes1: 500, minutes5: 400, threshold: 300)
}
