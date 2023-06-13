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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gameView
    }
}
