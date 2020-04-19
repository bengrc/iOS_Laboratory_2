//
//  ConversorViewController.swift
//  laboratory2
//
//  Created by Benjamin on 17/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import Foundation
import UIKit

class ConversorViewController: UIViewController {

    @IBOutlet weak var celsiusInput: parsedTextField!
    @IBOutlet weak var fahrenheitOutput: UILabel!
    var fahrenheitOutputPlaceholder: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.celsiusInput.delegate = self
        self.celsiusInput.maxLength = 7
        self.celsiusInput.allowedCharInString = ".0123456789"
        fahrenheitOutputPlaceholder = fahrenheitOutput.text
    }

    /// MeasurementFormatter sucks, so I need a workarroud
    func formatCelsiusToFahrenheit(_ celsius: Measurement<UnitTemperature>) -> String {
        let fahrenheiht = celsius.converted(to: UnitTemperature.fahrenheit)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit // Override locale
        measurementFormatter.numberFormatter.maximumFractionDigits = 2 // precision should be 2
        measurementFormatter.unitStyle = .short // I can't remove the unit, so let's make it one character
        let formattedStringWithUnit = measurementFormatter.string(from: fahrenheiht)
        return String(formattedStringWithUnit.dropLast()) // Drop the degree at the end
    }
    
    @IBAction func onCelsiusEntered(_ sender: parsedTextField) {
        if celsiusInput.text == nil {
            fahrenheitOutput.text = fahrenheitOutputPlaceholder
            celsiusInput.shake()
            return
        }
        let number = Double(celsiusInput.text!)
        if number == nil {
            fahrenheitOutput.text = fahrenheitOutputPlaceholder
            celsiusInput.shake()
            return
        }
        let celsius = Measurement(value: number!, unit: UnitTemperature.celsius)
        fahrenheitOutput.text = formatCelsiusToFahrenheit(celsius)
    }

}

extension ConversorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        // Verify all the conditions
        if let limitedTextField = textField as? parsedTextField {
            let value = limitedTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
            if value == false {
                // Play the shake animation
                limitedTextField.shake()
            }
            return value
        }
        return true
    }
}
