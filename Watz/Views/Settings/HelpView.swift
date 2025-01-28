//
//  HelpView.swift
//  Watz
//
//  Created by Isaac Allport on 18/12/2024.
//

import SwiftUI

struct HelpView: View {
    var body: some View {
        List {
            Section("Ho to use") {
                Text("To use the application first correctly set the athlete information seen in the settings part of the application. Then enter some maximal efforts you have performed in the efforts section, you should use a variety of range of efforts from sprints to 20 minute efforts, the more data provided the more accurate. Then the application will process this data analysing your power profile and will then give you infomation about your current level in home, your race level in ranking and then suggested training to become more well rounded in the Training section ")
            }
            Section("FAQ") {
                Text("Can I sync my data with strava")
                Text("No you can't as the processing of data imported from strava is against their terms and conditions")
            }
        }
        .navigationTitle("Help")
    }
}

#Preview {
    HelpView()
}
