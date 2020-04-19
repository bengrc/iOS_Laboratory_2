//
//  RespondViewController.swift
//  laboratory2
//
//  Created by Benjamin on 18/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import Foundation
import UIKit

class RespondViewController: UIViewController {
    @IBOutlet weak var textField: parsedTextField!
    @IBOutlet weak var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.textField.valueType = .onlyLetters
        self.textField.maxLength = 8
    }

    @IBAction func onTouch(_ sender: UIButton) {
        if (textField.text!.isEmpty) {
            return
        } else {
            label.text = textField.text
        }
    }
}

extension RespondViewController: UITextFieldDelegate {
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
