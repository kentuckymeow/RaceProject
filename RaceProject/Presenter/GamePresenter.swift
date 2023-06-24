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
        viewController?.gameView.startFallingTruckAnimation()
    }
}
