//
//  BallModel.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import Foundation

struct BallModel: Codable {
    var magic: Magic
}

struct Magic: Codable {
    var answer: String
    var type: String
}
