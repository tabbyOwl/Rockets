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

    
//    func load(id: String?, completion: @escaping (Launches?) -> Void) {
//
//        guard let id = id else {
//            completion(nil)
//            return
//        }
//
//        let query: [String: Any] = [
//            "query": ["rocket":"\(id)"],
//            "options": []
//        ]
//
//       let baseURL = URL(string: "https://api.spacexdata.com/v4")!
//       var request = URLRequest(url: baseURL.appendingPathComponent("/launches/query"))
//       request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//       request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
//       request.httpMethod = "POST"
//
//        URLSession.shared.dataTask(with: request) { (data, response , error) in
//            if let error = error {
//                print(error)
//            }
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let result = try JSONDecoder().decode(Launches.self, from: data)
//                completion(result)
//            } catch {
//                print(error.localizedDescription)
//            }
//        }.resume()
//    }
//}
