//
//  SettingsViewController.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    var viewModel = SettingsViewModel()
    
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
        return viewModel.settingsTableModel.count
    }
    
    // making each tableview cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
            fatalError("xib does not exists")
        }
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.cellLabel.text = viewModel.settingsTableModel[indexPath.row].title
        cell.cellTextField.text = viewModel.settingsTableModel[indexPath.row].fieldToChange
        cell.cellTextField.tag = indexPath.row
        cell.delegate = viewModel // SettingsCellDelegate
        return cell
    }
}
