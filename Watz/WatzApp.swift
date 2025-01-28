//
//  WatzApp.swift
//  Watz
//
//  Created by Isaac Allport on 25/10/2024.
//

import SwiftUI
import SwiftData

@main
struct WatzApp: App {
    var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: Effort.self)
        } catch {
            fatalError("Failed to configure SwiftData container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
