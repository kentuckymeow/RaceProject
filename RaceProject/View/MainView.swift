//
//  MainViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 06.06.2023.
//

import UIKit

final class MainView: UIView {
    
    private var backgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "background")
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = UIScreen.main.bounds
        return backgroundImageView
    }()
    
    private var logoImageView: UIImageView = {
        let logoImage = UIImage(named: "logo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFill
        return logoImageView
    }()

    var startButton: UIButton = {
        let startButton = UIButton()
        startButton.backgroundColor = .white
        startButton.setTitle("START GAME", for: .normal)
        startButton.setTitleColor(.black, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 23)
        startButton.layer.cornerRadius = 23
        return startButton
    }()

    private lazy var scoreRect: UIView = {
        let scoreRect = UIView()
        scoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        return scoreRect
    }()

    private lazy var bestScoreRect: UIView = {
        let bestScoreRect = UIView()
        bestScoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        return bestScoreRect
    }()

    private lazy var score: UILabel = {
        let score = UILabel(frame: scoreRect.bounds)
        score.text = "0"
        score.textAlignment = .center
        score.textColor = .white
        score.font = UIFont.boldSystemFont(ofSize: 40)
        return score
    }()

    private lazy var bestScore: UILabel = {
        let bestScore = UILabel(frame: bestScoreRect.bounds)
        bestScore.text = "Best Score"
        bestScore.textAlignment = .center
        bestScore.textColor = .white
        bestScore.font = UIFont.boldSystemFont(ofSize: 25)
        return bestScore
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        setUpViews()
        setUpConstraints()
    }
    
    private func setUpViews() {
        [backgroundImageView,logoImageView, startButton, scoreRect, bestScoreRect, score, bestScore].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        [backgroundImageView, logoImageView, startButton, scoreRect, bestScoreRect].forEach { addSubview($0)}
        
        scoreRect.addSubview(score)
        bestScoreRect.addSubview(bestScore)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.093),
            
            scoreRect.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreRect.widthAnchor.constraint(equalToConstant: 92),
            scoreRect.heightAnchor.constraint(equalToConstant: 66),
            scoreRect.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.077),
            
            score.centerXAnchor.constraint(equalTo: scoreRect.centerXAnchor),
            score.centerYAnchor.constraint(equalTo: scoreRect.centerYAnchor),
            
            bestScore.centerXAnchor.constraint(equalTo: bestScoreRect.centerXAnchor),
            bestScore.centerYAnchor.constraint(equalTo: bestScoreRect.centerYAnchor),
            
            bestScoreRect.centerXAnchor.constraint(equalTo: centerXAnchor),
            bestScoreRect.widthAnchor.constraint(equalToConstant: 165),
            bestScoreRect.heightAnchor.constraint(equalToConstant: 49),
            bestScoreRect.topAnchor.constraint(equalTo: scoreRect.bottomAnchor, constant: UIScreen.main.bounds.height * 0.012),
            
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 306),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.156)
        ])
    }
}
