//
//  MainViewModel.swift
//  BallOfTruth
//
//  Created by Илья on 22.02.2022.
//

import Foundation

class MainViewModel: NSObject {
    
    private var networkDataProvider: NetworkDataProvider
    
    var model: MainModel?
    
    init(networkDataProvider: NetworkDataProvider = NetworkManager()) {
        self.networkDataProvider = networkDataProvider
    }
    
    func getMessage() {
        networkDataProvider.fetchData { result in

            switch result {
            case .success(let ball):
                
                // if request was successfull result of request saves to variable
                self.model = self.createModel(ball: ball)
            case .failure(let error):
                print(error.localizedDescription)
                
                // if request was unsuccessfull variable assigns hardcoded error text
                self.model = MainModel(message: DefaultsModel.shared.shakeError) 
            }
        }
    }
    
    func createModel(ball: BallModel) -> MainModel {
        print(ball)
        return MainModel(message: ball.magic.answer)
    }
}
