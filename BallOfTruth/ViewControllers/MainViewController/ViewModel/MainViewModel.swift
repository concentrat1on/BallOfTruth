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
    
    func getMessage(completion: @escaping ((MainModel) -> Void)) {
        networkDataProvider.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let ball):
                
                // if request was successfull result of request saves to variable
                self.model = self.createModel(ball.magic.answer)
                completion(self.model!)
            case .failure(let error):
                print(error.localizedDescription)
                
                // if request was unsuccessfull variable assigns hardcoded error text
                self.model = self.createModel(DefaultsModel.shared.shakeError)
                completion(self.model!)
            }
        }
    }
    
    private func createModel(_ text: String) -> MainModel {
        print(text)
        return MainModel(message: text)
    }
}
