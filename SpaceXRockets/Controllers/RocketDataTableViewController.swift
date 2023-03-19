//
//  TableView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 07.09.2022.
//

import Foundation
import UIKit

protocol RocketDataTableViewControllerDelegate: AnyObject {
    func showSettingsViewController()
}

class RocketDataTableViewController: UIViewController {
     var rocket: Rocket? {
        didSet {
            setRocketData()
            self.tableView.reloadData()
        }
    }
    
    // MARK: private properties
    
    weak var collectionViewControllerDelegate: CollectionViewControllerDelegate?
    weak var mainCollectionViewControllerDelegate: MainCollectionViewControllerDelegate?
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
        view.isUserInteractionEnabled = true
        view.addSubview(tableView)
        setupFooterView()
        setupHeaderView()
    }
 
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    //MARK: private methods
    
    private func setupFooterView() {
        let footerView = FooterView()
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 90)
        footerView.button.addTarget(self, action: #selector(launchesInfoTapped), for: .touchUpInside)
        tableView.tableFooterView = footerView
    }
    
    @objc private func launchesInfoTapped() {
        mainCollectionViewControllerDelegate?.showLaunchInfo()
    }
    
    private func setupHeaderView() {
        let view = HeaderView()
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: UIScreen.main.bounds.height/2)
        if let rocket = rocket {
            view.setupImage(url: rocket.images[0])
            view.setupName(name: rocket.name)
        }
        view.rocketDataTableViewControllerDelegate = self
        tableView.tableHeaderView = view
    }

    private func setRocketData() {
        sections.removeAll()
        guard let rocket = rocket else {return}
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
                  firstValue: Value(value: heightMeters,
                                    unit: .m),
                  secondValue: Value(value: heightFeets,
                                     unit: .ft)),
            .init(name: "Диаметр",
                  firstValue: Value(value:diameterMeters,
                                    unit: .m),
                  secondValue: Value(value:diameterFeets,
                                     unit: .ft)),
            .init(name: "Масса",
                  firstValue: Value(value: String(massKg),
                                    unit: .kg),
                  secondValue: Value(value:String(massLb),
                                     unit: .lb)),
            .init(name: "Нагрузка",
                  firstValue: Value(value:payloadKg,
                                    unit: .kg),
                  secondValue: Value(value:payloadLb,
                                     unit: .lb))
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
        let burnTimeSec = stage.burnTimeSec ?? 0
        let fuelAmountTons = stage.fuelAmountTons
    
        let stageData: [RocketDataForCell] = [
            .init(name: "Количество двигателей",
                  value: "\(stage.engines)"),
            .init(name: "Количество топлива",
                  value: "\(fuelAmountTons.removeZeros()) ton"),
            .init(name: "Время сгорания",
                  value: "\(burnTimeSec.removeZeros()) sec")]
        
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
            if let cell = cell as? TableCellWithParametersCollection {
                cell.configure(with: parameters)
            }
        case .generalData(let generalData):
            (cell as? RocketDataTableCell)?.configure(with: generalData[indexPath.row])
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

extension RocketDataTableViewController: RocketDataTableViewControllerDelegate {
    func showSettingsViewController() {
        
        let vc = SettingsTableViewController()
        let navigationVC = UINavigationController(rootViewController: vc)
        vc.parameters = parameters
        self.view.window?.rootViewController?.present(navigationVC, animated: true)
    }
}

