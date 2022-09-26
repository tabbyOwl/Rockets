//
//  HeaderView.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 20.09.2022.
//

import UIKit

class HeaderView: UIView {
    
    private var view = NameAndSettingsView()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .white
        
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .clear
        return imageView
    }()
    
 
    func setupImage(url: String) {
        if let url = URL(string: url) {
            imageView.load(url: url)
        }
    }
    
    func setupName(name: String) {
        view.configure(with: name)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews(imageView,view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

       setupConstraints()
    }
    
    private func setupConstraints() {

  
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.rightAnchor.constraint(equalTo: rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

}
