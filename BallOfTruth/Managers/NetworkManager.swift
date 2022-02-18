//
//  NetworkManager.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import Foundation

enum NetworkManagerError: String, Error {
    
    case somethingWentWrong = "Sorry, something went wrong"
    case unauthorized = "Invalid authorization, please check api key"
    case noConnection = "No internet connection, please check it"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let apiURL = "https://8ball.delegator.com/magic/JSON/somequestion"
    
    func getPrediction(completion: @escaping (Result<BallModel, NetworkManagerError>) -> Void) {
        
        guard let url = URL(string: apiURL) else {
            completion(.failure(.somethingWentWrong))
            return
        }
        
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        let session = URLSession(configuration: config)
        
        session.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.noConnection))
                return
            }
            
            guard let _ = response as? HTTPURLResponse else {
                completion(.failure(.somethingWentWrong))
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.somethingWentWrong))
                return
            }
            
            do {
                let ball = try JSONDecoder().decode(BallModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(ball))
                }
            } catch let error {
                print("DEBUG: \(error.localizedDescription))")
                completion(.failure(.unauthorized))
            }
        } .resume()
    }
}
