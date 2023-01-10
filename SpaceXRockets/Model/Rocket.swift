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

//var rocketss = [Rocket(name: "Falcon 1",
//                       height: HeightAndDiameterData(meters: 5, feet: 5),
//                       diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                       mass: Mass(kg: 0, lb: 0),
//                       payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                       firstFlight: "0",
//                       country: "0",
//                       costPerLaunch: 0, images: [""],
//                       firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                       secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                Rocket(name: "Falcon 2",
//                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                     mass: Mass(kg: 0, lb: 0),
//                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                     firstFlight: "0",
//                                     country: "0",
//                                     costPerLaunch: 0,images: [""],
//                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                     secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                Rocket(name: "Falcon 3",
//                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                     mass: Mass(kg: 0, lb: 0),
//                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                     firstFlight: "0",
//                                     country: "0",
//                                     costPerLaunch: 0,images: [""],
//                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                     secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                Rocket(name: "Falcon 4",
//                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                     mass: Mass(kg: 0, lb: 0),
//                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                     firstFlight: "0",
//                                     country: "0",
//                                     costPerLaunch: 0,images: [""],
//                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                     secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                Rocket(name: "Falcon 5",
//                                       height: HeightAndDiameterData(meters: 5, feet: 5),
//                                       diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                       mass: Mass(kg: 0, lb: 0),
//                                       payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                       firstFlight: "0",
//                                       country: "0",
//                                       costPerLaunch: 0, images: [""],
//                                       firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                       secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                                Rocket(name: "Falcon 6",
//                                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     mass: Mass(kg: 0, lb: 0),
//                                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                                     firstFlight: "0",
//                                                     country: "0",
//                                                     costPerLaunch: 0,images: [""],
//                                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                                     secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                                Rocket(name: "Falcon 7",
//                                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     mass: Mass(kg: 0, lb: 0),
//                                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                                     firstFlight: "0",
//                                                     country: "0",
//                                                     costPerLaunch: 0,images: [""],
//                                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                                     secondStage: Stage(engines: 0, fuelAmountTons: 0)),
//                                Rocket(name: "Falcon 8",
//                                                     height: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     diameter: HeightAndDiameterData(meters: 0, feet: 0),
//                                                     mass: Mass(kg: 0, lb: 0),
//                                                     payloadWeights: [PayloadWeights(id: "leo", name: "fhjd", kg: 0, lb: 0)],
//                                                     firstFlight: "0",
//                                                     country: "0",
//                                                     costPerLaunch: 0,images: [""],
//                                                     firstStage: Stage(engines: 0, fuelAmountTons: 0),
//                                                     secondStage: Stage(engines: 0, fuelAmountTons: 0))
//              ]
