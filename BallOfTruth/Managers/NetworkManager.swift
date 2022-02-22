//
//  NetworkManager.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import Foundation
import Alamofire

enum NetworkManagerError: String, Error {
    
    case somethingWentWrong = "Sorry, something went wrong"
    case unauthorized = "Invalid authorization, please check api key"
    case noConnection = "No internet connection, please check it"
}

class NetworkManager: NetworkDataProvider {
    
    static let shared = NetworkManager()
    
    private let apiURL = "https://8ball.delegator.com/magic/JSON/somequestion"
    
    func fetchData(completion: @escaping (Result<BallModel, NetworkManagerError>) -> Void) {
        
        guard let url = URL(string: apiURL) else {
            completion(.failure(.somethingWentWrong))
            return
        }
        
        AF.request(url)
          .validate()
          .responseDecodable(of: BallModel.self) { (response) in
              
              guard let _ = response.response else {
                  completion(.failure(.somethingWentWrong))
                  return
              }
              
              guard let value = response.value else {
                  completion(.failure(.somethingWentWrong))
                  return
              }
              completion(.success(value))
          }

    }
}
