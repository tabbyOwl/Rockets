//
//  MainCollectionCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 08.09.2022.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionCell"
    
   let rocketTableViewController = RocketDataTableViewController()
    
    //MARK: - Public methods
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with model: Rocket) {
      
        rocketTableViewController.rocket = model
        contentView.addSubview(rocketTableViewController.view)
        setupConstraints()
     
    }
 
    // MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([

            rocketTableViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketTableViewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rocketTableViewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
}


//class MainCollectionCell: UICollectionViewCell {
//
//    static let identifier = "MainCollectionCell"
//    private var rocket: Rocket?
//    private var unit = ""
//
//    private var sections = [SectionType]()
//
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .black
//        tableView.contentInsetAdjustmentBehavior = .never
//        tableView.register(TableCellWithParametersCollection.self, forCellReuseIdentifier: TableCellWithParametersCollection.identifier)
//        tableView.register(RocketDataTableCell.self, forCellReuseIdentifier: RocketDataTableCell.identifier)
//        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
//        tableView.estimatedRowHeight = 50
//        tableView.separatorStyle = .none
//        return tableView
//    }()
//
//    //MARK: - Public methods
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        tableView.delegate = self
//        tableView.dataSource = self
//        contentView.addSubview(tableView)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(with model: Rocket) {
//
//        self.rocket = model
//        setRocketData()
//        setupConstraints()
//        setupHeaderView()
//        setupFooterView()
//        //tableView.reloadData()
//    }
//
//    // MARK: - Private methods
//
//    private func setupFooterView() {
//
//        let footerView = FooterView()
//        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 90)
//        tableView.tableFooterView = footerView
//
//    }
//
//    private func setupHeaderView() {
//
//        let view = HeaderView()
//        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: UIScreen.main.bounds.height/2)
//        view.setupImage(url: rocket?.images[0] ?? "")
//        view.setupName(name: rocket?.name ?? "")
//        tableView.tableHeaderView = view
//    }
//
//    private func setRocketData() {
//
//        guard let rocket = rocket
//        else {return}
//
//        setParameters(rocket: rocket)
//        setGeneralData(rocket: rocket)
//        setStageData(stage: rocket.firstStage, section: 1)
//        setStageData(stage: rocket.secondStage, section: 2)
//    }
//
//    private func setParameters(rocket: Rocket) {
//
//        guard let payload = rocket.payloadWeights.first(where: {$0.id == "leo"}) else { return }
//
//        let parameters: [Parameters] = [
//            .init(name: "Высота", value: ["\(String(describing: rocket.height.meters.forTrailingZero()))",
//                                          "\(String(describing: rocket.height.feet.forTrailingZero()))",]),
//            .init(name: "Диаметр", value: ["\(String(describing: rocket.diameter.meters.forTrailingZero()))",
//                                           "\(String(describing: rocket.diameter.feet.forTrailingZero()))"]),
//            .init(name: "Масса", value: ["\(String(describing:rocket.mass.kg.forTrailingZero()))",
//                                         "\(String(describing:rocket.mass.lb.forTrailingZero()))"]),
//            .init(name: "Нагрузка", value: ["\(String(describing: payload.kg.forTrailingZero()))",
//                                            "\(String(describing: payload.lb.forTrailingZero()))"])]
//        sections.append(.parameters(model: parameters))
//    }
//
//    private func setGeneralData(rocket: Rocket) {
//
//        let costPerLaunch = "$\((rocket.costPerLaunch/1000000).forTrailingZero()) млн"
//
//       let date = rocket.firstFlight.formattedDateFromString(inputFormat: "yyyy-mm-dd")
//        let country = NSLocalizedString(rocket.country, comment: "")
//
//        let generalData: [RocketDataCell] = [
//            .init(name: "Первый запуск", value: date),
//            .init(name: "Страна", value: "\(country)"),
//            .init(name: "Стоимость запуска", value: "\(costPerLaunch)")]
//        self.sections.append(.generalData(model: generalData))
//    }
//
//    private func setStageData(stage: Stage, section: Int) {
//
//        guard let burnTimeSec = stage.burnTimeSec?.forTrailingZero() else { return }
//        let fuelAmountTons = stage.fuelAmountTons.forTrailingZero()
//
//        let stageOneData: [RocketDataCell] = [
//            .init(name: "Количество двигателей", value: "\(stage.engines)"),
//            .init(name: "Количество топлива", value: "\(fuelAmountTons) ton"),
//            .init(name: "Время сгорания", value: "\(burnTimeSec) sec")]
//
//        if section == 1 {
//            self.sections.append(.firstStage(model: stageOneData))
//        } else if section == 2 {
//            self.sections.append(.secondStage(model: stageOneData))
//        }
//    }
//
//    private func setupConstraints() {
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//
//            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            tableView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
//            tableView.leftAnchor.constraint(equalTo: contentView.leftAnchor)
//        ])
//    }
//}
//
//    // MARK: - TableView data source
//
//extension MainCollectionCell: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        print("🐼")
//
//        let sectionType = sections[indexPath.section]
//
//        var cellIdentifier = ""
//
//        switch sectionType {
//        case .parameters:
//            cellIdentifier = TableCellWithParametersCollection.identifier
//        case .generalData, .firstStage, .secondStage:
//            cellIdentifier = RocketDataTableCell.identifier
//        }
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
//               else { return UITableViewCell() }
//
//        switch sectionType {
//        case .parameters(let parameters):
//            (cell as? TableCellWithParametersCollection)?.updateCell(with: parameters)
//        case .generalData(let generalData): (cell as? RocketDataTableCell)?.configure(with: generalData[indexPath.row])
//        case .firstStage(let stageOneData):
//            (cell as? RocketDataTableCell)?.configure(with: stageOneData[indexPath.row])
//        case .secondStage(let stageTwoData):
//            (cell as? RocketDataTableCell)?.configure(with: stageTwoData[indexPath.row])
//        }
//
//        return cell
//}
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        let sectionType = sections[indexPath.section]
//        print("🦉")
//        print( sectionType)
//        switch sectionType {
//        case .parameters: return 120
//        default: return 50
//    }
//}
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        let sectionType = sections[section]
//
//        switch sectionType {
//        case .generalData(let generalData):
//            return generalData.count
//        case .firstStage(let firstStage):
//            return firstStage.count
//        case .secondStage(model: let secondStage):
//            return secondStage.count
//        default: return 1
//    }
//}
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        print(sections.count)
//        return sections.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        let sectionType = sections[section]
//
//        switch sectionType {
//        case .firstStage:
//            return "ПЕРВАЯ СТУПЕНЬ"
//        case .secondStage:
//            return "ВТОРАЯ СТУПЕНЬ"
//        default: return ""
//        }
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
//
//        let header = view as? UITableViewHeaderFooterView
//        header?.textLabel?.textColor = UIColor.white
//    }
//}

