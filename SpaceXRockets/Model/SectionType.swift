//
//  SectionType.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 15.09.2022.
//

import Foundation

enum SectionType {

    case parameters(model: [Parameters])
    case generalData(model: [RocketDataForCell])
    case firstStage(model: [RocketDataForCell])
    case secondStage(model: [RocketDataForCell])

}
