//
//  CalculatorViewController.swift
//  laboratory2
//
//  Created by Benjamin on 17/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import Foundation
import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var firstValue: parsedTextField!
    @IBOutlet weak var secondValue: parsedTextField!
    @IBOutlet weak var sum: UILabel!
    @IBOutlet weak var substraction: UILabel!
    @IBOutlet weak var multiplication: UILabel!
    @IBOutlet weak var division: UILabel!
    @IBOutlet weak var parity: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstValue.delegate = self
        self.secondValue.delegate = self
        self.firstValue.valueType = .onlyNumbers
        self.secondValue.valueType = .onlyNumbers
        self.firstValue.maxLength = 6
        self.secondValue.maxLength = 6
    }
    
    func division(firstNumber: Int, secondNumber: Int) {
        if (secondNumber == 0) {
            division.text = "null"
        } else {
            division.text = String(firstNumber / secondNumber)
        }
    }

    func getParity(number: Int) -> String {
        if (number % 2 == 0) {
            return "yes"
        } else {
            return "no"
        }
    }
    
    func parity(firstNumber: Int, secondNumber: Int) {
        parity.text = "(" + getParity(number: firstNumber) + "/" + getParity(number: secondNumber) + ")"
    }
    
    func getNumber(str: String?) -> Int {
        let value = Int(str!)
        if (value == nil) {
            return 0
        } else {
            return value!
        }
    }
    
    func calculate(firstNumber: Int, secondNumber: Int) {
        sum.text = String(firstNumber + secondNumber)
        substraction.text = String(firstNumber - secondNumber)
        multiplication.text = String(firstNumber * secondNumber)
        division(firstNumber: firstNumber, secondNumber: secondNumber)
        parity(firstNumber: firstNumber, secondNumber: secondNumber)
    }
    
    @IBAction func onValues() {
        calculate(firstNumber: getNumber(str: firstValue.text), secondNumber: getNumber(str: secondValue.text))
    }
}

extension CalculatorViewController: UITextFieldDelegate {
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
