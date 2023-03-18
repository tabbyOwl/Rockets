//
//  RocketLaunches.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.08.2022.
//

import Foundation
import UIKit

class LaunchesViewController: UIViewController {
    
    var rocket: Rocket?
    var launches: [Launch]?
    
    private var sortedLaunches: [Launch] {

        guard let rocket = rocket,
        let launches = launches else { return []}
        return launches.filter({ $0.rocketId == rocket.id })
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(LaunchesTableCell.self, forCellReuseIdentifier: LaunchesTableCell.identifier)
        tableView.estimatedRowHeight = 40
        tableView.sectionHeaderTopPadding = 40
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = .clear
        navigationController?.navigationBar.tintColor = .white

        
        fetchLaunches()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    @objc private func goBack() {
        navigationItem.titleView?.isHidden = true
        navigationController?.isNavigationBarHidden = true
        navigationController?.dismiss(animated: true)
    }
    
    private func fetchLaunches() {
        
        guard let id = rocket?.id else {return}
        LaunchesService().load(id: id) { [self] result in
                DispatchQueue.main.async {
                    self.launches = result
                    self.tableView.reloadData()
                }
            }
    }
}

extension LaunchesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LaunchesTableCell.identifier) as? LaunchesTableCell else { return UITableViewCell()}
            cell.configure(with: sortedLaunches[indexPath.row])
            return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedLaunches.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
