//
//  GamePresenter.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import Foundation
import UIKit

class GamePresenter: GamePresenterProtocol {
    
    weak var gameView: GameView?
    
    init(gameView: GameView) {
        self.gameView = gameView
    }
    
    func leftArrowButtonTapped() {
        let newX = (gameView?.carImageView.frame.origin.x ?? 0) - ((gameView?.horizontalSpacing ?? 0) * 1.15 )
        if newX >= gameView?.sidePadding ?? 0 {
            UIView.animate(withDuration: 0.2) {
                self.gameView?.carImageView.frame.origin.x = newX
            }
        }
    }
    
    func rightArrowButtonTapped() {
        let newX = (gameView?.carImageView.frame.origin.x ?? 0) + ((gameView?.horizontalSpacing ?? 0) * 1.15 )
        if newX <= (gameView?.screenWidth ?? 0) - (gameView?.sidePadding ?? 0) - (gameView?.carImageView.frame.width ?? 0) {
            UIView.animate(withDuration: 0.2) {
                self.gameView?.carImageView.frame.origin.x = newX
            }
        }
    }
}
