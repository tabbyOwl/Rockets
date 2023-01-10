//
//  UIImageView + URL.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 09.09.2022.
//

import UIKit

extension UIImageView {
    
    func load(url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
    
}
