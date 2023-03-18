//
//  CollectionCell.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 23.08.2022.
//

import UIKit

class RocketParametersCollectionCell: UICollectionViewCell {
    
    static let identifier = "CollectionCell"
    
    // MARK: - Private properties
    
    private let baseView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 35
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.opacity = 0.5
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    //MARK: override methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = contentView.bounds.height
        let width = contentView.bounds.width
        
        baseView.frame = CGRect(x: 0,
                                y: 0,
                                width: width,
                                height: height)
        valueLabel.frame = CGRect(x: 0,
                                  y: height/3,
                                  width: width,
                                  height: height/5)
        nameLabel.frame = CGRect(x: 0,
                                 y: valueLabel.frame.maxY ,
                                 width: width,
                                 height: height/5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear
        baseView.addSubviews(valueLabel,nameLabel)
        contentView.addSubview(baseView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func configure(with model: Parameters, numberOfSegment: Int) {
        if UserDefaults.standard.integer(forKey: "segmentedIndex\(numberOfSegment)") == 0 {
            nameLabel.text = "\(model.name), \(model.firstValue.unit)"
            valueLabel.text = "\(model.firstValue.value)"
        } else {
            nameLabel.text = "\(model.name), \(model.secondValue.unit)"
            valueLabel.text = "\(model.secondValue.value)"
        }
    }
}

