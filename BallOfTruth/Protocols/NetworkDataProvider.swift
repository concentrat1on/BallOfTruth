//
//  NetworkDataProvider.swift
//  BallOfTruth
//
//  Created by Илья on 22.02.2022.
//

import Foundation

protocol NetworkDataProvider {
    func fetchData(completion: @escaping (Result<BallModel, NetworkManagerError>) -> Void)
}
