//
//  ContentView.swift
//  UnitConversions
//
//  Created by Paulina Dąbrowska on 06/01/2023.
//

import SwiftUI

struct ContentView: View {
    
    let temperatureUnits : [String] = ["Celsius", "Fahrenheit", "Kelvin"]
    
    @State private var inputUnit : String = "Celsius"
    @State private var outputUnit : String = "Celsius"
    @State private var inputValue : Double = 0.0
    
    var outputValue : Double {
        
        var calculatedValue : Double = inputValue
        
        if inputUnit == outputUnit {
            return calculatedValue
        }
        
        switch inputUnit {
        case "Celsius":
            if outputUnit == "Fahrenheit" {
                calculatedValue = celciusToFahrenheit(from: inputValue)
            } else {
                calculatedValue = celciusToKelvin(from: inputValue)
            }
            break;
        case "Fahrenheit":
            if outputUnit == "Celsius" {
                calculatedValue = fahrenheitToCelcius(from: inputValue)
            } else {
                calculatedValue = celciusToKelvin(from: fahrenheitToCelcius(from: inputValue))
            }
            break;
        case "Kelvin":
            if outputUnit == "Celsius" {
                calculatedValue = kelvinToCelcius(from: inputValue)
            } else {
                calculatedValue = celciusToFahrenheit(from: kelvinToCelcius(from: inputValue))
            }
            break;
        default:
            calculatedValue = 0.0
        }
        
        return calculatedValue
    }
    
    @FocusState private var isKeyboardFocused : Bool
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(temperatureUnits, id: \.self){
                            Text($0)
                        }
                    }
                } header: {
                    Text("Pick the input units")
                }
                
                Section {
                    TextField("Input value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isKeyboardFocused)
                    
                } header: {
                    Text("Value to be converted")
                }
                
                Section {
                    Picker("Output unit", selection: $outputUnit){
                        ForEach(temperatureUnits, id: \.self) {
                            Text($0)
                        }
                    }
                } header: {
                    Text("Pick the output units")
                }
                
                Section {
                    Text(outputValue, format: .number)
                } header: {
                    Text("Converted value")
                }
            }
        }
    }
}

func celciusToFahrenheit(from : Double) -> Double {
    return from * 1.8 + 32
}
func fahrenheitToCelcius(from : Double) -> Double {
    return (from - 32) / 1.8
}

func celciusToKelvin(from : Double) -> Double {
    return from + 273.15
}
func kelvinToCelcius(from : Double) -> Double {
    return from - 273.15
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
