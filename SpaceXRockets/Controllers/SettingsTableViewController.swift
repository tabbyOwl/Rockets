//
//  SettingsViewController.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.08.2022.
//

import Foundation
import UIKit

class SettingsTableViewController: UIViewController {

    private let items = [Items(name: "Высота", units: ["m", "ft"]),
                         Items(name: "Диаметр", units: ["m", "ft"]),
                         Items(name: "Масса", units: ["kg", "lb"]),
                         Items(name: "Нагрузка", units: ["kg", "lb"])]
  
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
        
        setupNavigationController()
    
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        setupConstraints()
    }
    
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
        
        navigationController?.dismiss(animated: true)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func tapSegmentedControl(_ sender: UISegmentedControl) {
      
        let item = items[sender.tag]
      
        if sender.selectedSegmentIndex == 1 {
            UserDefaults.standard.setValue(item.units[1], forKey: item.name)
            UserDefaults.standard.setValue(1, forKey: "segmentedIndex\(sender.tag)")
            NotificationCenter.default.post(name: Notification.Name("CollectionNotification"), object: nil)
        } else {
            UserDefaults.standard.setValue(item.units[0], forKey: item.name)
            UserDefaults.standard.setValue(0, forKey: "segmentedIndex\(sender.tag)")
            NotificationCenter.default.post(name: Notification.Name("CollectionNotification"), object: nil)
        }
    }
}

extension SettingsTableViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableCell.identifier) as? SettingsTableCell else { return UITableViewCell()}
        
        cell.configure(with: items[indexPath.row], tag: indexPath.row)
        cell.segmentedControl.tag = indexPath.row
        cell.segmentedControl.addTarget(self, action: #selector(self.tapSegmentedControl), for: .valueChanged)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70
    }
}
