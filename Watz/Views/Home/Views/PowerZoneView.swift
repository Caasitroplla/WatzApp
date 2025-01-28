//
//  PowerZoneView.swift
//  Watz
//
//  Created by Isaac Allport on 05/12/2024.
//

import SwiftUI

struct PowerZoneView: View {
    
    var powerZones: [[Int]]
    
    var headers: [String] = ["Recovery", "Endurance", "Tempo", "Threshold", "VO2 MAX", "Anaerobic"]
    
    var body: some View {
        VStack {
            Text("PowerZones")
                .font(.headline)
            ForEach(0..<6) { index in
                HStack {
                    Text(headers[index])
                        .bold()
                    Spacer()
                    Text("\(powerZones[index].first ?? 0) - \(powerZones[index].last ?? 0)")
                }
                
                .padding(1)
            }
        }
    }
    
}

#Preview {
    List {
        PowerZoneView(powerZones: [[0, 150], [151, 231], [232, 321], [322, 350], [350, 450], [451, 999]])
    }
}
