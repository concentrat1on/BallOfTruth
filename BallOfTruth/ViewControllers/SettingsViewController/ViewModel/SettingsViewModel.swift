//
//  SettingsViewModel.swift
//  BallOfTruth
//
//  Created by Илья on 22.02.2022.
//

import Foundation
import UIKit

// enum to make code more cleaner than using <if, else in SettingsCellDelegate>
enum TextFieldData: Int {
    case welcomeTextField = 0
    case shakeTextField = 1
    case cancelledTextField = 2
    case errorTextField = 3
}

class SettingsViewModel {
    
    var settingsTableModel = [SettingsCellModel(title: "Welcome ball text", fieldToChange: DefaultsModel.shared.welcomeString),
                              SettingsCellModel(title: "Text while shaking phone", fieldToChange: DefaultsModel.shared.shakeString),
                              SettingsCellModel(title: "Text if shaking cancelled", fieldToChange: DefaultsModel.shared.shakeCancelled),
                              SettingsCellModel(title: "Some error text", fieldToChange: DefaultsModel.shared.shakeError)]
}

extension SettingsViewModel: SettingsCellDelegate {
    func tableViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SettingsCell) {
        guard let text = textField.text else {
            return
        }
        print("textField text: \(text)")
        switch textField.tag {
        case TextFieldData.welcomeTextField.rawValue:
            DefaultsModel.shared.welcomeString = text
        case TextFieldData.shakeTextField.rawValue:
            DefaultsModel.shared.shakeString = text
        case TextFieldData.cancelledTextField.rawValue:
            DefaultsModel.shared.shakeCancelled = text
        case TextFieldData.errorTextField.rawValue:
            DefaultsModel.shared.shakeError = text
        default:
            break
        }
    }
    
    func tableViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SettingsCell) -> Bool {
        print("Now editing : \(cell) at index: \(textField.tag)")
        return true
    }
}


