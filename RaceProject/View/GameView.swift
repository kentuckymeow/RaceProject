//
//  GameView.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 13.06.2023.
//

import UIKit

enum Direction {
    case left
    case right
}

final class GameView: UIView {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    private var stripeWidth: CGFloat { screenWidth * 0.03 }
    var stripeHeight: CGFloat { screenHeight * 0.03 }
    var horizontalSpacing: CGFloat { screenWidth * 0.25 }
    var verticalSpacing: CGFloat { screenHeight * 0.05 }
    var sidePadding: CGFloat { screenWidth * 0.05 }
    
     lazy var horizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = horizontalSpacing
        let stackViewWidth = screenWidth - 2 * sidePadding
        horizontalStackView.frame = CGRect(x: sidePadding, y: -screenHeight, width: stackViewWidth, height: screenHeight * 2)
        return horizontalStackView
    }()
    
    var carImageView: UIImageView = {
        let carImage = UIImage(named: "car")
        let carImageView = UIImageView(image: carImage)
        carImageView.contentMode = .scaleAspectFill
        return carImageView
    }()
    
    lazy var truckImageView: UIImageView = {
        let truckImage = UIImage(named: "truck")
        let truckImageView = UIImageView(image: truckImage)
        truckImageView.contentMode = .scaleAspectFill
        let positionsTruple = getPositions(truckImageView)
        let center = positionsTruple.center
        let left = positionsTruple.left
        let right = positionsTruple.right
        let randomX = CGFloat.random(in: left...right)
        truckImageView.frame = CGRect(x: randomX, y: -screenHeight, width: 120, height: 170)
        return truckImageView
    }()
    
    private var scoreGameView: UIView = {
        let scoreGameView = UIView()
        scoreGameView.backgroundColor = UIColor(red: 0.792, green: 0.181, blue: 0.181, alpha: 1)
        scoreGameView.layer.cornerRadius = 25
        return scoreGameView
    }()
    
    private var scoreGameLabel: UILabel = {
        let scoreGameLabel = UILabel()
        scoreGameLabel.text = "0"
        scoreGameLabel.textAlignment = .center
        scoreGameLabel.textColor = .white
        scoreGameLabel.font = UIFont.boldSystemFont(ofSize: 23)
        return scoreGameLabel
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
    }
    
    private func setUpViews() {
        backgroundColor = UIColor.lightGray
        
        let numberOfRows = Int((screenHeight - stripeHeight) / (stripeHeight + verticalSpacing))
        
        [horizontalStackView, truckImageView, carImageView ,leftArrowButton, rightArrowButton, scoreGameView].forEach {addSubview($0)}
        [carImageView, leftArrowButton, rightArrowButton, scoreGameView, scoreGameLabel].forEach {$0.translatesAutoresizingMaskIntoConstraints = false}
        
        scoreGameView.addSubview(scoreGameLabel)
        
        bringSubviewToFront(carImageView)
        
        
        for _ in 0..<4 {
            let verticalStackView = createVerticalStackView(numberOfRows: numberOfRows)
            horizontalStackView.addArrangedSubview(verticalStackView)
        }
    }
    
    func startFallingTruckAnimation() {
        let positionsTuple = getPositions(truckImageView)
        let positions = [positionsTuple.left, positionsTuple.center, positionsTuple.right]
        let randomIndex = Int.random(in: 0..<positions.count)
        let randomPosition = positions[randomIndex]

        UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveLinear, animations: {
            self.truckImageView.frame = CGRect(x: self.truckImageView.frame.origin.x, y: self.screenHeight/1.4, width: self.truckImageView.frame.size.width, height: self.truckImageView.frame.size.height)
        }, completion: { _ in
            if self.carImageView.frame.intersects(self.truckImageView.frame) {
                print("Truck and car intersected")
            } else {
                if let score = Int(self.scoreGameLabel.text ?? "0") {
                    self.scoreGameLabel.text = String(score + 1)
                }
            }

            UIView.animate(withDuration: 3.0, delay: 0.0, options: .curveLinear, animations: {
                self.truckImageView.frame = CGRect(x: self.truckImageView.frame.origin.x, y: self.screenHeight * 2, width: self.truckImageView.frame.size.width, height: self.truckImageView.frame.size.height)
            }, completion: { _ in
                self.truckImageView.frame = CGRect(x: randomPosition, y: -self.screenHeight, width: self.truckImageView.frame.size.width, height: self.truckImageView.frame.size.height)
                self.startFallingTruckAnimation()
            })
        })
    }



    func moveCar(direction: Direction) {
        var newX: CGFloat
        switch direction {
        case .right:
            newX = carImageView.frame.origin.x + (horizontalSpacing * 1.15)
            if newX > screenWidth - sidePadding - carImageView.frame.width {
                return
            }
        case .left:
            newX = carImageView.frame.origin.x - (horizontalSpacing * 1.15)
            if newX < sidePadding {
                return
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.carImageView.frame.origin.x = newX
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
            carImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.153),
            carImageView.widthAnchor.constraint(equalToConstant: 50),
            carImageView.heightAnchor.constraint(equalToConstant: 103),
            carImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scoreGameView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIScreen.main.bounds.height * -0.055),
            scoreGameView.widthAnchor.constraint(equalToConstant: 140),
            scoreGameView.heightAnchor.constraint(equalToConstant: 60),
            scoreGameView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            scoreGameLabel.centerXAnchor.constraint(equalTo: scoreGameView.centerXAnchor),
            scoreGameLabel.centerYAnchor.constraint(equalTo: scoreGameView.centerYAnchor),
            
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
    
    private func getPositions(_ imageView: UIImageView) -> (center: CGFloat, left: CGFloat, right: CGFloat) {
        let center = screenWidth/2 - imageView.frame.width / 2
        let left = center - horizontalSpacing * 1.15
        let right = center + horizontalSpacing * 1.15
        return (center, left, right)
    }
}
