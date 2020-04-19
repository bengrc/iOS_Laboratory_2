//
//  TempartureConversorViewController.swift
//  laboratory2
//
//  Created by Benjamin on 17/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import Foundation
import UIKit

class TemperatureConversorViewController: UIViewController {
    @IBOutlet weak var celsius: parsedTextField!
    @IBOutlet weak var fahrenheit: UILabel!
    var null: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.celsius.delegate = self
        self.null = self.fahrenheit.text
        self.celsius.allowedCharInString = ".0123456789"
        self.celsius.maxLength = 8
    }
    
    func celsiusToFahrenheit(_ celsius: Measurement<UnitTemperature>) -> String {
        let fahrenheiht = celsius.converted(to: UnitTemperature.fahrenheit)
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.numberFormatter.maximumFractionDigits = 2
        measurementFormatter.unitStyle = .short;
        let formattedStringWithUnit = measurementFormatter.string(from: fahrenheiht);
        return String(formattedStringWithUnit.dropLast());
    }
    
    @IBAction func onCelsiusInput(_ sender: parsedTextField) {
        let value = Double(celsius.text!)
        if value == nil {
            fahrenheit.text = null
            return
        }
        let celsius = Measurement(value: value!, unit: UnitTemperature.celsius)
        fahrenheit.text = celsiusToFahrenheit(celsius)
    }
}

extension TemperatureConversorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let parsedTextField = textField as? parsedTextField {
            let value = parsedTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
            return value
        }
        return true
    }
}

