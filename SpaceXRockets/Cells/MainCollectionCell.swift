//
//  MainCollectionCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 08.09.2022.
//

import UIKit

class MainCollectionCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionCell"
    
    private let rocketTableViewController = RocketDataTableViewController()
    
    //MARK: - Public methods
    
    func configure(with model: Rocket) {
      
        rocketTableViewController.rocket = model
        contentView.addSubview(rocketTableViewController.view)
        //setupConstraints()
        //rocketTableViewController.reloadTable()
    }
 
    // MARK: - Private methods
    
    private func setupConstraints() {
        
        rocketTableViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            rocketTableViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            rocketTableViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            rocketTableViewController.view.leftAnchor.constraint(equalTo: contentView.rightAnchor)
            
        ])
    }
}
