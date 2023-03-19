//
//  RosketParameters.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 223458.2022.
//

import Foundation

struct Rocket: Decodable {
    
    var sections = [SectionType]()
    
    let id: String
    let name: String
    var height: HeightAndDiameterData
    var diameter: HeightAndDiameterData
    var mass: Mass
    let payloadWeights: [PayloadWeights]
    var firstFlight: String
    var country: String
    var costPerLaunch: Double
    let images: [String]
    
    var firstStage: Stage
    var secondStage: Stage
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case height
        case diameter
        case mass
        case firstFlight = "first_flight"
        case country
        case costPerLaunch = "cost_per_launch"
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case images = "flickr_images"
    }
}

//MARK: support structs

struct PayloadWeights: Decodable {
    
    var id: String
    var name: String
    var kg: Double
    var lb: Double
}

struct HeightAndDiameterData: Decodable {
    var meters: Double
    var feet: Double
    
    enum CodingKeys: String, CodingKey {
        case meters
        case feet
    }
}

struct Mass: Decodable {
    var kg: Double
    var lb: Double
}

struct Stage: Decodable {
    var engines: Int
    var fuelAmountTons: Double
    var burnTimeSec: Double?
    
    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSec = "burn_time_sec"
    }
}
