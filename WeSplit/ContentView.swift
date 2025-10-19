//
//  ContentView.swift
//  WeSplit
//
//  Created by Rob Downing on 10/16/25.
//  Instructions from Paul Hudson's 100 Days of SwiftUI
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal / peopleCount
    }

    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount * (tipSelection / 100)
        return checkAmount + tipValue
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

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) { n in
                            Text("\(n) people").tag(n - 2)
                        }
                    }
                }

                // Tip picker on a new screen, 0%...100%
                Section("Tip") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<21) { step in
                            let pct = step * 5
                            Text(pct, format: .percent).tag(pct)
                        }
                    }
                }


                Section("Amount per person") {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }

                Section("Grand total (amount + tip)") {
                    Text(grandTotal,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") { amountIsFocused = false }
                }
            }
            .pickerStyle(.navigationLink) // makes pickers drill-in
        }
    }
}

#Preview { ContentView() }

