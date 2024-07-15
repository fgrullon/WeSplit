//
//  ContentView.swift
//  WeSplit
//
//  Created by Frank Grullon on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 0
    @State private var tipPercetage = 20
    
    @FocusState private var amountIsFocused : Bool
    
    

    var grandTotal : Double {
        let tipSelection = Double(tipPercetage)
        
        let tipValue = checkAmount / 100  * tipSelection
        let grandTotal = tipValue + checkAmount
        
        return grandTotal
    }
    
    var totalPerPerson : Double { grandTotal / Double(numberOfPeople + 2) }
    
    
    var body: some View {
        NavigationStack {
            Form{
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number Of People", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much do you wanna tip?"){
                    Picker("Tip Percentage", selection: $tipPercetage){
                        ForEach(0..<101){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Check Total Amount"){
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per Person"){
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
  
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
