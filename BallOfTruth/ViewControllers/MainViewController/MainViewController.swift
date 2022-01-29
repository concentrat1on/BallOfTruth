//
//  MainViewController.swift
//  BallOfTruth
//
//  Created by Илья on 25.01.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    weak private var ball: UIView!
    weak private var ballMiddle: UIView!
    weak private var messageText: UILabel!

    var messageString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    // on every page opening shows welcoming text with instructions what to do
    override func viewWillAppear(_ animated: Bool) {
        messageText.text = DefaultsModel.shared.welcomeString
    }
    
    // when user starts to shake device app sends network request to server and text on the screen changes to one of hardcoded variants
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageText.text = DefaultsModel.shared.shakeString
        messageString = ""
        loadMessage()
    }
    
    
    // after 1.5 seconds after shake shows text from json
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.messageText.text = self.messageString
        }
    }
    
    // if motion was cancelled it shows on the screen by using one of hardcoded answers
    override func motionCancelled(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        messageText.text = DefaultsModel.shared.shakeCancelled
    }
    
    private func loadMessage() {
        NetworkManager.shared.getPrediction { [weak self] result in
            guard self == self else { return }
            switch result {
            case .success(let message):
                print(message)
                
                // if request was successfull result of request saves to variable
                self?.messageString = message.magic.answer
            case .failure(let error):
                print(error.localizedDescription)
                
                // if request was unsuccessfull variable assigns hardcoded error text
                self?.messageString = DefaultsModel.shared.shakeError
            }
        }
    }

    
    // basic layout with constraints
    
    private func setupLayout() {
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.topItem?.title = "Main"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let ballWidth = UIScreen.main.bounds.width - 75
        let ball = UIView()
        ball.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ball)
        
        ball.widthAnchor.constraint(equalToConstant: ballWidth).isActive = true
        ball.heightAnchor.constraint(equalToConstant: ballWidth).isActive = true
        ball.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ball.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        ball.backgroundColor = .black
        ball.layer.cornerRadius = ballWidth / 2
        self.ball = ball
        
        let ballMiddle = UIView()
        ballMiddle.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ballMiddle)
        
        ballMiddle.widthAnchor.constraint(equalToConstant: ballWidth / 1.5).isActive = true
        ballMiddle.heightAnchor.constraint(equalToConstant: ballWidth / 1.5).isActive = true
        ballMiddle.centerXAnchor.constraint(equalTo: ball.centerXAnchor).isActive = true
        ballMiddle.centerYAnchor.constraint(equalTo: ball.centerYAnchor).isActive = true
        ballMiddle.backgroundColor = .white
        ballMiddle.layer.cornerRadius = ballWidth / 1.5 / 2
        self.ballMiddle = ballMiddle
        
        let messageText = UILabel()
        messageText.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageText)
        
        messageText.topAnchor.constraint(equalTo: ballMiddle.topAnchor, constant: 20).isActive = true
        messageText.bottomAnchor.constraint(equalTo: ballMiddle.bottomAnchor, constant: -20).isActive = true
        messageText.leadingAnchor.constraint(equalTo: ballMiddle.leadingAnchor, constant: 20).isActive = true
        messageText.trailingAnchor.constraint(equalTo: ballMiddle.trailingAnchor, constant: -20).isActive = true
        messageText.numberOfLines = 0
        messageText.textAlignment = .center
        messageText.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageText.textColor = .black
        messageText.text = DefaultsModel.shared.welcomeString
        self.messageText = messageText
    }
}
