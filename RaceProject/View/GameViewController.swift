//
//  GameViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import UIKit

class GameViewController: UIViewController {
    
    lazy var gameView: GameView = {
        return GameView()
    }()
    
    var musicManager: MusicManager = {
        return MusicManager()
    }()
    
    override func loadView() {
        super.loadView()
        view = gameView
        musicManager.play()
    }
    
    override func loadViewIfNeeded() {
        super.loadViewIfNeeded()
        animateStripeDrop()
    }
    
    func animateStripeDrop() {
        let screenHeight = gameView.screenHeight * 2
        let stripeHeight = gameView.stripeHeight
        let verticalSpacing = gameView.verticalSpacing
        let totalAnimationDuration = Double(screenHeight / stripeHeight) * 0.5

        for verticalStackView in gameView.horizontalStackView.arrangedSubviews {
            guard let stackView = verticalStackView as? UIStackView else { continue }

            for (index, stripeView) in stackView.arrangedSubviews.enumerated() {
                let initialPosition = CGPoint(x: stripeView.frame.origin.x, y: gameView.horizontalStackView.frame.origin.y + CGFloat(index) * (stripeHeight + verticalSpacing) - stripeHeight)
                let finalPosition = CGPoint(x: stripeView.frame.origin.x, y: screenHeight + CGFloat(index) * (stripeHeight + verticalSpacing) - stripeHeight)

                stripeView.frame.origin = initialPosition

                UIView.animate(withDuration: totalAnimationDuration, delay: Double(index) * 0.1, options: [.curveLinear, .repeat], animations: {
                    stripeView.frame.origin = finalPosition
                }, completion: nil)
            }
        }
    }
}
