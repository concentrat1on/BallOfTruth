//
//  SettingsViewController.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import UIKit

// enum to make code more cleaner than using <if, else in SettingsCellDelegate>
enum TextFieldData: Int {
    case welcomeTextField = 0
    case shakeTextField = 1
    case cancelledTextField = 2
    case errorTextField = 3
}


// simple struct to make TableViewModel
struct SettingsTableViewModel {
    var title: String
    var fieldToChange: String
}

class SettingsViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    var settingsTableViewModel = [SettingsTableViewModel(title: "Welcome ball text", fieldToChange: DefaultsModel.shared.welcomeString),
                                  SettingsTableViewModel(title: "Text while shaking phone", fieldToChange: DefaultsModel.shared.shakeString),
                                  SettingsTableViewModel(title: "Text if shaking cancelled", fieldToChange: DefaultsModel.shared.shakeCancelled),
                                  SettingsTableViewModel(title: "Some error text", fieldToChange: DefaultsModel.shared.shakeError)]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // basic layout with constraints
    private func setupLayout() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.topItem?.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
        self.tableView = tableView
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // how many cells tableview renders
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsTableViewModel.count
    }
    
    // making each tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.cellLabel.text = settingsTableViewModel[indexPath.row].title
        cell.cellTextField.text = settingsTableViewModel[indexPath.row].fieldToChange
        cell.cellTextField.tag = indexPath.row
        cell.delegate = self // SettingsCellDelegate
        return cell
    }
}

extension SettingsViewController: SettingsCellDelegate {
    
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
        print("Now editing : \(String(describing: tableView.indexPath(for: cell)))")
        return true
    }
}
