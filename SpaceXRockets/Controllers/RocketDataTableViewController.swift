//
//  TableView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 07.09.2022.
//

import Foundation
import UIKit

class RocketDataTableViewController: UIViewController {
    
    var rocket: Rocket? {
        didSet {
            setRocketData()
            print(rocket?.firstStage)
            tableView.reloadData()
        }
    }
    
    // MARK: private properties
    
    private var sections = [SectionType]()
    
    private var parameters: [Parameters] = []
    
    private let tableView: UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(TableCellWithParametersCollection.self, forCellReuseIdentifier: TableCellWithParametersCollection.identifier)
        tableView.register(RocketDataTableCell.self, forCellReuseIdentifier: RocketDataTableCell.identifier)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    //MARK: override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupConstraints()
        setupFooterView()
        setupNotification()
    }
    
    //MARK: private methods
    
    private func setupNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(pushSettingsViewController), name: Notification.Name("SettingsImageNotification"), object: nil)
    }
    
    @objc private func pushSettingsViewController() {
        
        let vc = SettingsTableViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.parameters = parameters
        self.view.window?.rootViewController?.present(navigationVC, animated: true)
    }
    
    private func setupFooterView() {
        
        let footerView = FooterView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 90)
        tableView.tableFooterView = footerView
    }
    
    private func setupHeaderView() {
        
        let view = HeaderView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: UIScreen.main.bounds.height/2)
        view.setupImage(url: rocket?.images[0] ?? "")
        view.setupName(name: rocket?.name ?? "")
        tableView.tableHeaderView = view
        tableView.tableHeaderView?.isUserInteractionEnabled = true
    }
    
    private func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setRocketData() {
        
        sections.removeAll()
        guard let rocket = rocket
        else {return}
        print(rocket.firstStage)
        setParameters(rocket: rocket)
        setGeneralData(rocket: rocket)
        setStageData(stage: rocket.firstStage, section: 1)
        setStageData(stage: rocket.secondStage, section: 2)
        setupHeaderView()
    }
    
    private func setParameters(rocket: Rocket) {
        
        guard let payload = rocket.payloadWeights.first(where: {$0.id == "leo"}) else { return }
        let heightMeters = rocket.height.meters.removeZeros()
        let heightFeets = rocket.height.feet.removeZeros()
        let diameterMeters = rocket.diameter.meters.removeZeros()
        let diameterFeets = rocket.diameter.feet.removeZeros()
        let massKg = round(rocket.mass.kg)
        let massLb = round(rocket.mass.lb)
        let payloadKg = payload.kg.removeZeros()
        let payloadLb = payload.kg.removeZeros()
        
        let parameters: [Parameters] = [
            .init(name: "Высота",
                  firstValue: [String(heightMeters), "m"],
                  secondValue: [String(heightFeets), "ft"]),
            .init(name: "Диаметр",
                  firstValue: [String(diameterMeters), "m"],
                  secondValue: [String(diameterFeets), "ft"]),
            .init(name: "Масса",
                  firstValue: [String(massKg), "kg"],
                  secondValue: [String(massLb), "lb"]),
            .init(name: "Нагрузка",
                  firstValue: [String(payloadKg), "kg"],
                  secondValue: [String(payloadLb), "lb"])
        ]
        sections.append(.parameters(model: parameters))
        self.parameters = parameters
    }
    
    private func setGeneralData(rocket: Rocket) {
        
        let costPerLaunch = "$\((rocket.costPerLaunch/1000000).removeZeros()) млн"
        
        let date = rocket.firstFlight.formattedDateFromString(inputFormat: "yyyy-mm-dd")
        let country = NSLocalizedString(rocket.country, comment: "")
        
        let generalData: [RocketDataForCell] = [
            .init(name: "Первый запуск", value: date),
            .init(name: "Страна", value: "\(country)"),
            .init(name: "Стоимость запуска", value: "\(costPerLaunch)")]
        self.sections.append(.generalData(model: generalData))
    }
    
    private func setStageData(stage: Stage, section: Int) {
        
        print(stage)
        let burnTimeSec = stage.burnTimeSec ?? 0
        let fuelAmountTons = stage.fuelAmountTons
    
        let stageData: [RocketDataForCell] = [
            .init(name: "Количество двигателей", value: "\(stage.engines)"),
            .init(name: "Количество топлива", value: "\(fuelAmountTons.removeZeros()) ton"),
            .init(name: "Время сгорания", value: "\(burnTimeSec.removeZeros()) sec")]
        
        
        if section == 1 {
            self.sections.append(.firstStage(model: stageData))
        } else if section == 2 {
            self.sections.append(.secondStage(model: stageData))
        }
    }
}

//MARK: Table data source

extension RocketDataTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionType = sections[indexPath.section]
        
        var cellIdentifier = ""
        
        switch sectionType {
        case .parameters:
            cellIdentifier = TableCellWithParametersCollection.identifier
        case .generalData, .firstStage, .secondStage:
            cellIdentifier = RocketDataTableCell.identifier
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        else { return UITableViewCell() }
        
        
        switch sectionType {
        case .parameters(let parameters):
            (cell as? TableCellWithParametersCollection)?.updateCell(with: parameters)
        case .generalData(let generalData): (cell as? RocketDataTableCell)?.configure(with: generalData[indexPath.row])
        case .firstStage(let stageOneData):
            (cell as? RocketDataTableCell)?.configure(with: stageOneData[indexPath.row])
        case .secondStage(let stageTwoData):
            (cell as? RocketDataTableCell)?.configure(with: stageTwoData[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .parameters: return 120
        default: return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let sectionType = sections[section]
        
        switch sectionType {
        case .generalData(let generalData):
            return generalData.count
        case .firstStage(let firstStage):
            return firstStage.count
        case .secondStage(model: let secondStage):
            return secondStage.count
        default: return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionType = sections[section]
        
        switch sectionType {
        case .firstStage:
            return "ПЕРВАЯ СТУПЕНЬ"
        case .secondStage:
            return "ВТОРАЯ СТУПЕНЬ"
        default: return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
}

