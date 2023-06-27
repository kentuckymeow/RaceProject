//
//  MainViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 06.06.2023.
//

import UIKit

final class MainView: UIView {
    
    private var backgroundImageView: UIImageView = {
        let backgroundImageView = UIImageView(image: UIImage(named: "background"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = UIScreen.main.bounds
        return backgroundImageView
    }()
    
    private var logoImageView: UIImageView = {
        let logoImageView = UIImageView(image: UIImage(named: "logo"))
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

    private lazy var scoreView: UIView = {
        let scoreRect = UIView()
        scoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        return scoreRect
    }()

    private lazy var bestScoreView: UIView = {
        let bestScoreRect = UIView()
        bestScoreRect.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        return bestScoreRect
    }()

    private lazy var scoreLabel: UILabel = {
        let score = UILabel(frame: scoreView.bounds)
        score.text = "0"
        score.textAlignment = .center
        score.textColor = .white
        score.font = UIFont.boldSystemFont(ofSize: 40)
        return score
    }()

    private lazy var bestScoreLabel: UILabel = {
        let bestScore = UILabel(frame: bestScoreView.bounds)
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
        [backgroundImageView,logoImageView, startButton, scoreView, bestScoreView, scoreLabel, bestScoreLabel].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }

        [backgroundImageView, logoImageView, startButton, scoreView, bestScoreView].forEach { addSubview($0)}
        
        scoreView.addSubview(scoreLabel)
        bestScoreView.addSubview(bestScoreLabel)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: UIScreen.main.bounds.height * 0.093),
            
            scoreView.centerXAnchor.constraint(equalTo: centerXAnchor),
            scoreView.widthAnchor.constraint(equalToConstant: 92),
            scoreView.heightAnchor.constraint(equalToConstant: 66),
            scoreView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.077),
            
            scoreLabel.centerXAnchor.constraint(equalTo: scoreView.centerXAnchor),
            scoreLabel.centerYAnchor.constraint(equalTo: scoreView.centerYAnchor),
            
            bestScoreLabel.centerXAnchor.constraint(equalTo: bestScoreView.centerXAnchor),
            bestScoreLabel.centerYAnchor.constraint(equalTo: bestScoreView.centerYAnchor),
            
            bestScoreView.centerXAnchor.constraint(equalTo: centerXAnchor),
            bestScoreView.widthAnchor.constraint(equalToConstant: 165),
            bestScoreView.heightAnchor.constraint(equalToConstant: 49),
            bestScoreView.topAnchor.constraint(equalTo: scoreView.bottomAnchor, constant: UIScreen.main.bounds.height * 0.012),
            
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            startButton.widthAnchor.constraint(equalToConstant: 306),
            startButton.heightAnchor.constraint(equalToConstant: 60),
            startButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.156)
        ])
    }
}
