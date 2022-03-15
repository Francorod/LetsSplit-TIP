//
//  ContentView.swift
//  LetsSplit
//
//  Created by Franco Rodrigues on 1/24/22.
//

import SwiftUI

struct ContentView: View {
    //properties
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [10,15,20,25,0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    //Content of the App
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    //Title of the field
                } header: {
                    Text ("Tip Total")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalPerPerson, format:.currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Total per person")
                }
            }
        }
        
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    amountIsFocused = false
                }
            }
        }
        
        .navigationTitle("LetsSplit")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
