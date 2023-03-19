//
//  HeaderView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.09.2022.
//

import UIKit

class HeaderView: UIView {
    
    weak var rocketDataTableViewControllerDelegate: RocketDataTableViewControllerDelegate?
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage( UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .white
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        return button
    }()

    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.tintColor = .black
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .systemFont(ofSize: 27, weight: .medium)
        label.numberOfLines = 1
        return label
    }()
    
  
    func setupImage(url: String) {
        if let url = URL(string: url) {
            imageView.load(url: url)
        }
    }
    
    func setupName(name: String) {
        nameLabel.text = name
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView.addSubviews(nameLabel, settingsButton)
        addSubviews(imageView,bottomView)
        settingsButton.addTarget(self, action: #selector(pushSettingsViewController), for: .touchUpInside)
    }
    
    @objc private func pushSettingsViewController() {
        rocketDataTableViewControllerDelegate?.showSettingsViewController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let bottomItemsInset: CGFloat = 30
        let bottomHeight = frame.height/4
        let bottomWidth = frame.width
        
        let buttonWidth: CGFloat = 30
        let buttonHeight: CGFloat = 30
        
        imageView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: frame.width,
                                 height: frame.height)
        bottomView.frame = CGRect(x: 0,
                                  y: frame.height - bottomHeight,
                                  width: bottomWidth,
                                  height: bottomHeight)
        nameLabel.frame = CGRect(x: bottomItemsInset,
                                 y: bottomItemsInset,
                                 width: bottomWidth/2,
                                 height: 30)
        settingsButton.frame = CGRect(x: bottomView.frame.maxX - buttonWidth - bottomItemsInset,
                                         y: bottomItemsInset,
                                          width: buttonWidth,
                                          height: buttonHeight)
    }
}
