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
    
    lazy var presenter: GamePresenter = {
        return GamePresenter(viewController: self)
    }()
    
    var musicManager: MusicManager = {
        return MusicManager()
    }()
    
    override func loadView() {
        super.loadView()
        view = gameView 
        //musicManager.play()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateStripeDrop(duration: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTargets()
    }
    
    @objc  func leftArrowButtonTapped() {
        presenter.leftArrowButtonTapped()
    }

    @objc  func rightArrowButtonTapped() {
        presenter.rightArrowButtonTapped()
    }
    
    private func setUpTargets() {
        gameView.leftArrowButton.addTarget(self, action: #selector(leftArrowButtonTapped), for: .touchUpInside)
        gameView.rightArrowButton.addTarget(self, action: #selector(rightArrowButtonTapped), for: .touchUpInside)
    }

    func animateStripeDrop(duration: Double?) {
        let screenHeight = gameView.screenHeight
        let stripeHeight = gameView.stripeHeight
        let verticalSpacing = gameView.verticalSpacing * 0.5
        let totalAnimationDuration = duration ?? Double(screenHeight / stripeHeight) * 0.05
        
        UIView.animate(withDuration: totalAnimationDuration, delay: 0, options: [.curveLinear, . repeat], animations: {
            self.gameView.horizontalStackView.frame.origin = CGPoint(x: self.gameView.sidePadding, y: verticalSpacing)
        }, completion: nil)
    }
}
