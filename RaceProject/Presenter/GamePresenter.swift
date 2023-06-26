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
            if let carFrame = self?.viewController?.gameView.carImageView.frame,
               let truckFrame = self?.viewController?.gameView.truckImageView.frame {
                if carFrame.intersects(truckFrame) {
                    print("Truck and car intersected")
                } else {
                    self?.score += 1
                    self?.viewController?.gameView.scoreGameLabel.text = String(self?.score ?? 0)
                    self?.viewController?.gameView.animationDuration *= 0.95
                }
            }
        }
    }
}

