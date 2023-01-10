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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.layer.opacity = 0.5
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    //MARK: override methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
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
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: - Public methods
    
    func configure(with model: Parameters, numberOfSegment: Int) {
        
        if UserDefaults.standard.integer(forKey: "segmentedIndex\(numberOfSegment)") == 0 {
            nameLabel.text = "\(model.name), \(model.firstValue[1])"
            valueLabel.text = "\(model.firstValue[0])"
        } else {
            nameLabel.text = "\(model.name), \(model.secondValue[1])"
            valueLabel.text = "\(model.secondValue[0])"
        }
    }
    
    // MARK: - Private methods
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            baseView.widthAnchor.constraint(equalToConstant: contentView.bounds.width),
            baseView.heightAnchor.constraint(equalToConstant: contentView.bounds.height),
            baseView.topAnchor.constraint(equalTo: contentView.topAnchor),
            baseView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            valueLabel.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
            valueLabel.centerYAnchor.constraint(equalTo: baseView.centerYAnchor, constant: -10),
            valueLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 5),
            nameLabel.widthAnchor.constraint(equalTo: baseView.widthAnchor)
        ])
    }
    
}


