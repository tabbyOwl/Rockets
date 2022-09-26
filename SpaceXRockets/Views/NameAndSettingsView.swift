//
//  NameAndSettingsView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.09.2022.
//

import UIKit

class NameAndSettingsView: UIView {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private var settingsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .black
        tintColor = .black
        layer.cornerRadius = 25
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
        addSubviews(nameLabel, settingsImageView)
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    private func setupGesture() {
    
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector (settingsInfoTapped))
        settingsImageView.addGestureRecognizer(gestureTap)
    }
    
    @objc private func settingsInfoTapped() {
        NotificationCenter.default.post(name: Notification.Name("SettingsImageNotification"), object: nil)
    }
    
    public func configure(with name: String) {
        nameLabel.text = name
        settingsImageView.image = UIImage(systemName: "gearshape")
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor,constant: 20),
            
            settingsImageView.widthAnchor.constraint(equalToConstant: 30),
            settingsImageView.heightAnchor.constraint(equalToConstant: 30),
            settingsImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            settingsImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}

    

