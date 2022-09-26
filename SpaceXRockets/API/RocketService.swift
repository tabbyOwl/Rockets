//
//  RocketServise.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 21.08.2022.
//

import Foundation

class RocketService {

    func load(completion: @escaping ([Rocket]) -> ()) {
        guard let url = URL(string: "https://api.spacexdata.com/v4/rockets")
        else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Rocket].self, from: data)
                completion(result)
            } catch {
                print(error)
            }
        }.resume()
    }
}
