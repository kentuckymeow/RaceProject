//
//  MainViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 06.06.2023.
//

import UIKit

class MainViewController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        
        let logoImage = UIImage(named: "logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        
        let startButton = UIButton()
        startButton.backgroundColor = .white
        startButton.setTitle("START GAME", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        startButton.layer.cornerRadius = 23
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(startButton)
        
        let scoreRect = UIView()
        scoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        scoreRect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scoreRect)
        
        let bestScoreRect = UIView()
        bestScoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        bestScoreRect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bestScoreRect)
        
        let score = UILabel(frame: scoreRect.bounds)
        score.text = "0"
        score.textAlignment = .center
        score.textColor = .white
        score.font = UIFont.boldSystemFont(ofSize: 40)
        score.translatesAutoresizingMaskIntoConstraints = false
        scoreRect.addSubview(score)
        
        let bestScore = UILabel(frame: bestScoreRect.bounds)
        bestScore.text = "Best Score"
        bestScore.textAlignment = .center
        bestScore.textColor = .white
        bestScore.font = UIFont.boldSystemFont(ofSize: 25)
        bestScore.translatesAutoresizingMaskIntoConstraints = false
        bestScoreRect.addSubview(bestScore)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.093),
            
            scoreRect.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreRect.widthAnchor.constraint(equalToConstant: 92),
            scoreRect.heightAnchor.constraint(equalToConstant: 66),
            scoreRect.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: view.bounds.height * 0.077),
            
            score.centerXAnchor.constraint(equalTo: scoreRect.centerXAnchor),
            score.centerYAnchor.constraint(equalTo: scoreRect.centerYAnchor),
            
            bestScore.centerXAnchor.constraint(equalTo: bestScoreRect.centerXAnchor),
            bestScore.centerYAnchor.constraint(equalTo: bestScoreRect.centerYAnchor),

            bestScoreRect.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bestScoreRect.widthAnchor.constraint(equalToConstant: 165),
            bestScoreRect.heightAnchor.constraint(equalToConstant: 49),
            bestScoreRect.topAnchor.constraint(equalTo: scoreRect.bottomAnchor, constant: view.bounds.height * 0.012),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 306),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.bounds.height * -0.156)
        ])
    }
    
    @objc func startButtonTapped() {
        let navigationController = UINavigationController(rootViewController: GameViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
}

