//
//  GameView.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import UIKit

final class GameView: UIView {
    
    private let musicManager = MusicManager()
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    private var stripeWidth: CGFloat { screenWidth * 0.03 }
    private var stripeHeight: CGFloat { screenHeight * 0.10 }
    private var horizontalSpacing: CGFloat { screenWidth * 0.25 }
    private var verticalSpacing: CGFloat { screenHeight * 0.05 }
    private var sidePadding: CGFloat { screenWidth * 0.05 }
    
    private lazy var horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = horizontalSpacing
        return horizontalStackView
    }()
    
    private var carImageView: UIImageView = {
        let carImage = UIImage(named: "car")
        let carImageView = UIImageView(image: carImage)
        carImageView.contentMode = .scaleAspectFill
        return carImageView
    }()
    
    var leftArrowButton: UIButton = {
        let leftArrowButton = UIButton(type: .system)
        leftArrowButton.setImage(UIImage(named: "arrowLeft"), for: .normal)
        leftArrowButton.tintColor = .black
        return leftArrowButton
    }()
    
    var rightArrowButton: UIButton = {
        let rightArrowButton = UIButton(type: .system)
        rightArrowButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        rightArrowButton.tintColor = .black
        return rightArrowButton
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
        musicManager.play()
    }
    
    private func setUpViews() {
        backgroundColor = UIColor.lightGray
        
        let numberOfRows = Int((screenHeight - stripeHeight) / (stripeHeight + verticalSpacing))
    
        [horizontalStackView, carImageView ,leftArrowButton, rightArrowButton].forEach {addSubview($0)}
        [horizontalStackView, carImageView ,leftArrowButton, rightArrowButton].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        
        for _ in 0..<4 {
            let verticalStackView = createVerticalStackView(numberOfRows: numberOfRows)
            horizontalStackView.addArrangedSubview(verticalStackView)
        }
    }
    
    private func createVerticalStackView(numberOfRows: Int) -> UIStackView {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = verticalSpacing
        
        for _ in 0..<numberOfRows {
            let stripe = createStripe()
            verticalStackView.addArrangedSubview(stripe)
        }
        return verticalStackView
    }
    
    private func createStripe() -> UIView {
        let stripe = UIView()
        stripe.backgroundColor = .white
        stripe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stripe.widthAnchor.constraint(equalToConstant: stripeWidth),
            stripe.heightAnchor.constraint(equalToConstant: stripeHeight)
        ])
        return stripe
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sidePadding),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sidePadding),
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -143),
            carImageView.widthAnchor.constraint(equalToConstant: 50),
            carImageView.heightAnchor.constraint(equalToConstant: 103),
            carImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            leftArrowButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant:  UIScreen.main.bounds.height * -0.035),
            leftArrowButton.widthAnchor.constraint(equalToConstant: 90),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 90),
            leftArrowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),

            rightArrowButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant:  UIScreen.main.bounds.height * -0.035),
            rightArrowButton.widthAnchor.constraint(equalToConstant: 90),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 90),
            rightArrowButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
}
