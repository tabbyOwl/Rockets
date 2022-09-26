//
//  Double+TrailingZero.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 18.09.2022.
//

import Foundation

extension Double {

func forTrailingZero() -> String {
    
    let string = String(format: "%g", self)
    return string
}
}
