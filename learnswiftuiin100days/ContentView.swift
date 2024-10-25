//
//  ContentView.swift
//  learnswiftuiin100days
//
//  Created by sagar on 10/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var from: String = "m"
    @State private var to: String = "km"
    @State private var input:String = ""
    @State private var output:String = ""
    let items = ["m","km","ft","yards","miles"]
    
    var formatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 3
        nf.numberStyle = .decimal
        return nf
    }
    
    func convertDistance() {
        if let value = Double(input){
            let conversionRates: [String: Double] = [
                "m_to_km": 0.001,
                "m_to_ft": 3.28084,
                "m_to_yards": 1.09361,
                "m_to_miles": 0.000621371,
                "km_to_m": 1000,
                "km_to_ft": 3280.84,
                "km_to_yards": 1093.61,
                "km_to_miles": 0.621371,
                "ft_to_m": 0.3048,
                "ft_to_km": 0.0003048,
                "ft_to_yards": 0.333333,
                "ft_to_miles": 0.000189394,
                "yards_to_m": 0.9144,
                "yards_to_km": 0.0009144,
                "yards_to_ft": 3,
                "yards_to_miles": 0.000568182,
                "miles_to_m": 1609.34,
                "miles_to_km": 1.60934,
                "miles_to_ft": 5280,
                "miles_to_yards": 1760
            ]
            
            let key = "\(from)_to_\(to)"
            if let rate = conversionRates[key] {
                output = String(value * rate)
            } else {
                output = input
            }
        }
    }
    var body: some View {
        NavigationStack{
            Form {
                Section("From") {
                    Picker("from", selection: $from){
                        ForEach(items,id:\.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: to) { newValue in
                        if !input.isEmpty {
                            convertDistance()
                        }
                    }
                }
                Section("To") {
                    Picker("to", selection: $to){
                        ForEach(items, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: to) { newValue in
                        if !input.isEmpty {
                            convertDistance()
                        }
                    }
                }
                Section{
                    TextField("Enter data", value: $input, formatter: formatter)
                        .keyboardType(.decimalPad)
                        .onChange(of: input) { newValue in
                            convertDistance()
                        }
                }
                Section("Output") {
                    Text(!output.isEmpty ? "\(output) \(to)" : "")
                }
            }
            .navigationTitle("Distance conversion")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
