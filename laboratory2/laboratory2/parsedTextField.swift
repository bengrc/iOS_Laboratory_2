//
//  ParsedTextField.swift
//  laboratory2
//
//  Created by Benjamin on 17/04/2020.
//  Copyright © 2020 Benjamin. All rights reserved.
//

import Foundation
import UIKit

enum ValueType: Int {
    case none
    case onlyLetters
    case onlyNumbers
}

class parsedTextField: UITextField {
    @IBInspectable var maxLength: Int = 0
    var valueType: ValueType = .none
    @IBInspectable var allowedCharInString: String = ""

    func verifyFields(shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch valueType {
        case .none:
            break
        case .onlyLetters:
            let characterSet = CharacterSet.letters
            if string.rangeOfCharacter(from: characterSet.inverted) != nil {
                return false
            }
        case .onlyNumbers:
            let numberSet = CharacterSet.decimalDigits
            if string.rangeOfCharacter(from: numberSet.inverted) != nil {
                return false
            }
        }
        if let text = self.text, let textRange = Range(range, in: text) {
            let finalText = text.replacingCharacters(in: textRange, with: string)
            if maxLength > 0, maxLength < finalText.utf8.count {
                return false
            }
        }
        if !self.allowedCharInString.isEmpty {
            let customSet = CharacterSet(charactersIn: self.allowedCharInString)
            if string.rangeOfCharacter(from: customSet.inverted) != nil {
                return false
            }
        }
        return true
    }
}
