//
//  SettingsViewController.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.08.2022.
//

import Foundation
import UIKit


class SettingsTableViewController: UIViewController {
    
    var parameters: [Parameters] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(SettingsTableCell.self, forCellReuseIdentifier: SettingsTableCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 60, right: 0)
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderTopPadding = 40
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        setupNavigationController()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    //MARK: private methods
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.title = "Настройки"
        navigationController?.view.backgroundColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        let backButton = UIBarButtonItem(title: "Закрыть",
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        navigationItem.setRightBarButton(backButton, animated: true)
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func tapSegmentedControl(_ sender: UISegmentedControl) {
        let parameter = parameters[sender.tag]
      
        if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.setValue(parameter.firstValue.value, forKey: parameter.name)
            UserDefaults.standard.setValue(1, forKey: "segmentedIndex\(sender.tag)")
            NotificationCenter.default.post(name: Notification.Name.settingsNotification, object: nil)
        } else {
            UserDefaults.standard.setValue(parameter.secondValue.value, forKey: parameter.name)
            UserDefaults.standard.setValue(0, forKey: "segmentedIndex\(sender.tag)")
            NotificationCenter.default.post(name: Notification.Name.settingsNotification, object: nil)
        }
    }
}

//MARK: Table data source

extension SettingsTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        cell.configure(with: parameters[indexPath.row], numberOfSegment: indexPath.row)
        cell.segmentedControl.tag = indexPath.row
        cell.segmentedControl.addTarget(self, action: #selector(self.tapSegmentedControl), for: .valueChanged)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parameters.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

