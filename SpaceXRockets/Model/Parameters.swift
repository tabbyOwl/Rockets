//
//  Parameters.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 18.09.2022.
//

import Foundation


struct Parameters {
    let name: String
    let firstValue: Value
    let secondValue: Value
}

struct Value {
    let value: String
    let unit: Units
}

enum Units: String {
    case m = "m"
    case ft = "ft"
    case kg = "kg"
    case lb = "lb"
}
