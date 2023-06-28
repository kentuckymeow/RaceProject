//
//  MainPresenter.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 09.06.2023.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
   
    weak var viewController: MainViewController?
    
    init(viewController: MainViewController) {
        self.viewController = viewController
    }
    
    func startButtonTapped() {
        let navigationController = UINavigationController(rootViewController: GameViewController())
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController,animated: true)
    }
    
    func updateBestScore() {
        if let bestScore = UserDefaultsManager.shared.getValue(forKey: "BestScore") as? Int {
            viewController?.mainView.scoreLabel.text = String(bestScore)
           }
       }
}
