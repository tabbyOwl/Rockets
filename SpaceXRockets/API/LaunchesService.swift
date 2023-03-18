//
//  LaunchesService.swift
//  SpaceXRockets
//
//  Created by Svetlana Oleinikova on 13.09.2022.
//

import Foundation

class LaunchesService {
    
    func load(id: String?, completion: @escaping ([Launch]?) -> Void) {
        
        guard let id = id else {
            completion(nil)
            return
        }

        guard let url = URL(string: "https://api.spacexdata.com/v4/launches") else {return}
      
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let result = try JSONDecoder().decode([Launch].self, from: data)
                completion(result)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
