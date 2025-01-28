//
//  DataEntryView.swift
//  Watz
//
//  Created by Isaac Allport on 05/12/2024.
//

import SwiftUI
import SwiftData

struct DataEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var efforts: [Effort]
    
    @State private var isPresenting = false
    @State private var newEffortTime: TimeInterval = 0.0
    @State private var newEffortPower: Int = 0
    
    var body: some View {
        NavigationView {
            List {
                ForEach(efforts) { effort in
                    Text("\(String(effort.time))s at \(String(effort.power))W")
                }
                .onDelete(perform: deleteEfforts(at:))
                Section {
                    Text("Please enter 3 or more maximal efforts try to enter one for 1-5 seconds and one around to 5 minutes and one longer effort 20 minutes plus, the more efforts the more accurate.")
                        .font(.caption)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.clear)
                        )
                        .opacity(efforts.isEmpty ? 0 : 1)
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { addEffort() }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Efforts")
            .overlay {
                if efforts.isEmpty {
                    ContentUnavailableView {
                        Label("No efforts", systemImage: "list.bullet")
                    } description: {
                        Text("New efforts you create will appear here.")
                    }
                }
            }
            .sheet(isPresented: $isPresenting) {
                NavigationView {
                    NewDataItemView(newEffortTime: $newEffortTime, newEffortPower: $newEffortPower)
                        .navigationTitle("New Effort")
                        .toolbar {
                            ToolbarItem(
                                placement: .confirmationAction,
                                content: {
                                    Button("Add") {
                                        // Create a new item then add and blank variables again
                                        let newEffort = Effort(time: newEffortTime, power: newEffortPower)
                                        modelContext.insert(newEffort)
                                        newEffortTime = 0.0
                                        newEffortPower = 0
                                        isPresenting = false
                                    }
                                    .disabled(newEffortTime == 0 || newEffortPower == 0)
                                })
                            ToolbarItem(
                                placement: .cancellationAction,
                                content: {
                                    Button("Cancel") {
                                        newEffortTime = 0.0
                                        newEffortPower = 0
                                        isPresenting = false
                                    }
                                })
                        }
                }
            }
        }
    }
    
    func addEffort() {
        isPresenting = true
    }
    
    private func deleteEfforts(at offsets: IndexSet) {
        withAnimation {
            offsets.map { efforts[$0] }.forEach { effort in
                modelContext.delete(effort)
            }
        }
    }
}

#Preview {
    DataEntryView()
}
