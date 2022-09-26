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

    private let collectionViewController = CollectionViewController()

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
        setupConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func updateCell(with model: [Parameters]) {
        collectionViewController.parameters = model
        collectionViewController.collectionView.reloadData()
    }
    
    private func setupConstraints() {
        
        collectionViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            collectionViewController.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionViewController.view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionViewController.view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            collectionViewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

