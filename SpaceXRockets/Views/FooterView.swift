//
//  FooterView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 09.09.2022.
//

import UIKit

class FooterView: UIView {
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .init(white: 1, alpha: 0.1)
        button.setTitle("Посмотреть запуски", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 15
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.addTarget(self, action: #selector(launchesInfoTapped), for: .touchUpInside)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
      
        button.frame = CGRect(x: 20, y: 20, width: self.frame.size.width - 40, height: self.frame.size.height - 30)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func launchesInfoTapped() {
        NotificationCenter.default.post(name: Notification.Name("TableFooterNotification"), object: nil)
    }
}

