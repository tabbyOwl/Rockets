//
//  RocketCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 21.08.2022.
//

import UIKit

class RocketDataTableCell: UITableViewCell {
    
    static let identifier = "RocketTableCell"
    
    //MARK: - Private properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.opacity = 0.7
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.tintColor = .black
        contentView.clipsToBounds = true
        contentView.addSubviews(nameLabel, valueLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Public methods
    
    func configure(with model: CellDataProtocol) {
        nameLabel.text = model.name
        valueLabel.text = model.value
    }
    
    //MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            valueLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
}

