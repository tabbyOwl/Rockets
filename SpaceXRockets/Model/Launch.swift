//
//  Launch.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 13.09.2022.
//

import Foundation

struct Launch: Codable {
    
    var rocketId: String
    var name: String
    var isSuccess: Bool?
    var date: String?
    
    var formattedDate: String? {
        
        guard let date = self.date?.formattedDateFromString(inputFormat: "yyyy-mm-dd'T'hh:mm:sss-hh:mm") else { return ""}
        
        if date.isEmpty {
            return self.date?.formattedDateFromString(inputFormat: "yyyy-mm-dd'T'hh:mm:sss+hh:mm")
        } else {
            return date
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case rocketId = "rocket"
        case name
        case isSuccess = "success"
        case date = "date_local"
    }
}
