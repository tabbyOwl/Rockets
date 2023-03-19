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
    
    func configure(with model: Rocket) {
      
        rocketTableViewController.rocket = model
        contentView.addSubview(rocketTableViewController.view)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rocketTableViewController.rocket = nil
    }
}
