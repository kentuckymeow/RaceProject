//
//  GamePresenter.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import Foundation
import UIKit

class GamePresenter: GamePresenterProtocol {
    
    weak var viewController: GameViewController?
    
    private var score: Int = 0
    let animationDuration = 0.2
    let delayBeforeTransition = 3.0
    let speedIncreaseFactor = 0.95
    
    init(viewController: GameViewController) {
        self.viewController = viewController
    }
    
    func leftArrowButtonTapped() {
        viewController?.gameView.moveCar(direction: .left)

    }
    
    func rightArrowButtonTapped() {
        viewController?.gameView.moveCar(direction: .right)
    }
    
    func startTruck() {
        viewController?.gameView.startFallingTruckAnimation { [weak self] in
            guard let self = self else { return }
            self.checkIntersection()
        }
    }

    func checkIntersection() {
        guard let carFrame = viewController?.gameView.carImageView.frame,
              let truckFrame = viewController?.gameView.truckImageView.frame else { return }
        
        if carFrame.intersects(truckFrame) {
            handleIntersection()
        } else {
            updateScore()
        }
    }

    func handleIntersection() {
        print("Truck and car intersected")
        viewController?.gameView.gameOverView.alpha = 0.0
        viewController?.gameView.gameOverView.isHidden = false
        
        UIView.animate(withDuration: animationDuration) {
            self.viewController?.gameView.gameOverView.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delayBeforeTransition) { [weak self] in
            self?.transitionToMainViewController()
        }
    }

    func updateScore() {
        score += 1
        viewController?.gameView.scoreGameLabel.text = String(score)
        viewController?.gameView.animationDuration *= speedIncreaseFactor
    }

    func transitionToMainViewController() {
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = navigationController
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
