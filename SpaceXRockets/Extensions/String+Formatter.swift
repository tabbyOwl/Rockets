//
//  Date+Formatter.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 18.09.2022.
//

import Foundation

extension String {
    
    func formattedDateFromString(inputFormat: String) -> String {
        var string = ""
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = inputFormat
        
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd MMMM, yyyy"
            string = outputFormatter.string(from: date)
        }
        return string
    }
}
