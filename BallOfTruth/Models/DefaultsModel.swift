//
//  DefaultsModel.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import Foundation

class DefaultsModel {
    
    static let shared = DefaultsModel()
    
    var welcomeString: String {
        didSet {
            UserDefaults.standard.set(welcomeString, forKey: "welcomeString")
        }
    }
    
    var shakeString: String {
        didSet {
            UserDefaults.standard.set(shakeString, forKey: "shakeString")
        }
    }
    
    var shakeCancelled: String {
        didSet {
            UserDefaults.standard.set(shakeCancelled, forKey: "shakeCancelled")
        }
    }
    
    var shakeError: String {
        didSet {
            UserDefaults.standard.set(shakeError, forKey: "shakeError")
        }
    }
    
    init() {
        self.welcomeString = UserDefaults.standard.string(forKey: "welcomeString") ?? "Shake phone to get prediction"
        self.shakeString = UserDefaults.standard.string(forKey: "shakeString") ?? "Shaking"
        self.shakeCancelled = UserDefaults.standard.string(forKey: "shakeCancelled") ?? "Something went wrong"
        self.shakeError = UserDefaults.standard.string(forKey: "shakeError") ?? "We have problems"
    }
    
    
}
