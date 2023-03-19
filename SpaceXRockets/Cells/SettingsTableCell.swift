//
//  SettingsTableCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 13.09.2022.
//

import Foundation
import UIKit

class SettingsTableCell: UITableViewCell {
    
    static let identifier = "SettingsTableCell"
    
    var segmentedControl = UISegmentedControl()
    
    // MARK: - Private properties
    
    private var units: [String] = []
 
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    //MARK: override methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.tintColor = .black
        contentView.clipsToBounds = true
        contentView.addSubviews(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: public methods
    
    func configure(with model: Parameters, numberOfSegment: Int) {
        self.nameLabel.text = model.name
        units.append(model.firstValue.unit.rawValue)
        units.append(model.secondValue.unit.rawValue)
        setupSegmentedControl(numberOfSegment: numberOfSegment)
        setupConstraints()
    }
   
    //MARK: private methods
    
    private func setupSegmentedControl(numberOfSegment: Int) {
        let control = UISegmentedControl(items: units)
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "segmentedIndex\(numberOfSegment)")
        control.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        control.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        control.setWidth(50, forSegmentAt: 0)
        control.setWidth(50, forSegmentAt: 1)
        control.backgroundColor = .black
        control.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl = control
        contentView.addSubview(segmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            segmentedControl.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            segmentedControl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30)
         
        ])
    }
}

