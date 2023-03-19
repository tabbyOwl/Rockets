//
//  RocketLaunchesTableCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 10.09.2022.
//

import Foundation
import UIKit

class LaunchesTableCell: UITableViewCell {
    
    static let identifier = "LaunchesTableCell"
    
    //MARK: - Private properties
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 1, alpha: 0.08)
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.clipsToBounds = true
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.layer.opacity = 0.5
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        rocketImageView.addSubview(statusImageView)
        baseView.addSubviews(nameLabel, dateLabel, rocketImageView)
        contentView.addSubview(baseView)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

 
    //MARK: - Public methods
    
    func configure(with model: Launch) {
        setImage(model: model)
        nameLabel.text = model.name
        dateLabel.text = model.formattedDate
    }
    
    //MARK: - Private methods
    
    private func setImage(model: Launch) {
        if model.isSuccess == true {
            rocketImageView.image = UIImage(named: "SuccessfulLaunch")
            statusImageView.image = UIImage(systemName: "checkmark.circle.fill")
            statusImageView.tintColor = .green
        } else {
            rocketImageView.image = UIImage(named: "UnSuccessfulLaunch")
            statusImageView.image = UIImage(systemName: "xmark.circle.fill")
            statusImageView.tintColor = .red
        }
    }
 
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            baseView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            baseView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            nameLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: baseView.topAnchor, constant: 30),
            nameLabel.rightAnchor.constraint(equalTo: rocketImageView.leftAnchor, constant: -5),
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.leftAnchor.constraint(equalTo: baseView.leftAnchor, constant: 20),
            
            rocketImageView.rightAnchor.constraint(equalTo: baseView.rightAnchor, constant: -20),
            rocketImageView.centerYAnchor.constraint(equalTo: baseView.centerYAnchor),
            rocketImageView.widthAnchor.constraint(equalToConstant: 40),
            rocketImageView.heightAnchor.constraint(equalToConstant: 40),
            
            statusImageView.rightAnchor.constraint(equalTo: rocketImageView.rightAnchor, constant: -3),
            statusImageView.topAnchor.constraint(equalTo: rocketImageView.topAnchor, constant: 20),
            statusImageView.widthAnchor.constraint(equalToConstant: 15),
            statusImageView.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
