//
//  ContentView.swift
//  WeTemp
//
//  Created by James Bailey on 18/03/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var tempAmount = 0.0
    @State private var measSelect = "Celsius"
    @State private var measChoice = "Fahrenheit"
    @FocusState private var amountIsFocused: Bool
    let measurement = ["Celsius", "Kelvin", "Fahrenheit"]

    var conversion: Double {
        var tempConv = 1.1
        if measSelect == "Celsius" && measChoice == "Fahrenheit" {
            tempConv = (tempAmount*(9/5))+32
        } else if measSelect == "Fahrenheit" && measChoice == "Celsius" {
            tempConv = (tempAmount-32)*(5/9)
        } else if measSelect == "Celsius" && measChoice == "Kelvin" {
            tempConv = tempAmount + 273.15
        } else if measSelect == "Fahrenheit" && measChoice == "Kelvin"{
            tempConv = (tempAmount-32)*(5/9) + 273.15
        } else if measSelect == "Kelvin" && measChoice == "Celsius" {
            tempConv = tempAmount - 273.15
        } else if measSelect == "Kelvin" && measChoice == "Fahrenheit" {
            tempConv = ((tempAmount - 273.15)*(9/5)) + 32
        } else {
            tempConv = tempAmount
        }
        
        return tempConv
    }

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $tempAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Measurement", selection: $measSelect) {
                        ForEach(measurement, id: \.self) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("Temperature")
                }
                Section {
                    Picker("Measurement", selection: $measChoice) {
                        ForEach(measurement , id: \.self) {
                            Text("\($0)")
                        }
                    }
                } header: {
                    Text("What do you want to convert to?")
                }
                Section {
                    Text("\(conversion, format: .number) \(measChoice)")
                } header: {
                    Text("Conversion")
                }
            }
            .navigationTitle("WeTemp")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
