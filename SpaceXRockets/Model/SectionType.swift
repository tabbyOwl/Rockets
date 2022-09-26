//
//  SectionType.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 15.09.2022.
//

import Foundation

enum SectionType {

    case parameters(model: [Parameters])
    case generalData(model: [RocketDataCell])
    case firstStage(model: [RocketDataCell])
    case secondStage(model: [RocketDataCell])

}
