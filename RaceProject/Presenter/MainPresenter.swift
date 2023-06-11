//
//  MainPresenter.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 09.06.2023.
//

import UIKit

class MainPresenter: UINavigationController {
    
    lazy var mainView: MainView = {
        return MainView()
    }()
    
    override func loadView() {
       super.loadView()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func startButtonTapped() {
        let navigationController = UINavigationController(rootViewController: GameViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController,animated: true)
    }
}

