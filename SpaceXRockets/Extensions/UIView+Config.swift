//
//  UIView + Ext.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 21.08.2022.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
