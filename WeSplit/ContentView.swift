//
//  ContentView.swift
//  WeSplit
//
//  Created by Rob Downing on 10/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0        // 0 means 2 people, 1 means 3 people, etc. (0-based)
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]

    // MARK: - Computed total per person (matches the instructions)
    var totalPerPerson: Double {
        // correct number of people is the stored value + 2
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)

        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Amount & People") {
                    TextField(
                        "Amount",
                        value: $checkAmount,
                        format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                    )
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)

                    // Picker shows 2...99 people, but stores 0-based selection to match the lesson
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { n in
                            Text("\(n) people")
                                .tag(n - 2) // <-- store 0 for 2 people, 1 for 3 people, etc.
                        }
                    }
                }

                Section("Tip") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { pct in
                            Text(pct, format: .percent).tag(pct)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Final section now shows per-person total as requested
                Section("Total per person") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
            .pickerStyle(.navigationLink)
        }
    }
}

#Preview { ContentView() }

