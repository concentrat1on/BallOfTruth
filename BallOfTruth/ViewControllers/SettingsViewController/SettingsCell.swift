//
//  SettingsCell.swift
//  BallOfTruth
//
//  Created by Илья on 29.01.2022.
//

import UIKit

// protocol to delegate cells textfield to SettingsViewController
protocol SettingsCellDelegate: AnyObject {
    func tableViewCell(valueChangedIn textField: UITextField, delegatedFrom cell: SettingsCell)
    func tableViewCell(textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String, delegatedFrom cell: SettingsCell)  -> Bool
}

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellTextField: UITextField!

    weak var delegate: SettingsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellLabel.textColor = .black
        cellLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cellLabel.text = "cell"
        
        cellTextField.backgroundColor = .white
        cellTextField.borderStyle = .roundedRect
        cellTextField.delegate = self // UITextFieldDelegate
        cellTextField.addTarget(self, action: #selector(valueChanged(_ :)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // every time textfield changes it delegates to SettingsViewController it value
    @objc private func valueChanged(_ textField: UITextField) {
        delegate?.tableViewCell(valueChangedIn: cellTextField, delegatedFrom: self)
    }
    
}


extension SettingsCell: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegate {
            return delegate.tableViewCell(textField: textField, shouldChangeCharactersIn: range, replacementString: string, delegatedFrom: self)
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called")
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("TextField did end editing with reason method called")
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder()
        return true
    }
}
