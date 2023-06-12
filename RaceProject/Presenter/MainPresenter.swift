//
//  MainPresenter.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 09.06.2023.
//

import UIKit

class MainPresenter: MainPresenterProtocol {
   
    weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func startButtonTapped() {
        let navigationController = UINavigationController(rootViewController: GameViewController())
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController,animated: true)
    }
}

