//
//  HorizontalStackCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 23.08.2022.
//

import Foundation
import UIKit


class TableCellWithParametersCollection : UITableViewCell {
    
    static let identifier = "TableCellWithCollection"

    // MARK: - Private properties
    
     let collectionViewController = CollectionViewController()

    //MARK: override methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .black
        contentView.tintColor = .black
        contentView.clipsToBounds = true
        contentView.addSubview(collectionViewController.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViewController.view.frame = contentView.bounds
    }
    
    //MARK: - Public methods
    
    func configure(with model: [Parameters]) {
        collectionViewController.parameters = model
    }
}

