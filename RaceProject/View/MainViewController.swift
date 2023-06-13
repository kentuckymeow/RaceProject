//
//  MainViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 12.06.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var mainView: MainView = {
        return MainView()
    }()
    
    lazy var presenter: MainPresenterProtocol = {
        return MainPresenter(viewController: self)
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
        presenter.startButtonTapped()
    }
}
