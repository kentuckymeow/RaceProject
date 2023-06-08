//
//  GameViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 06.06.2023.
//

import UIKit

class GameViewController: UIViewController {
    var stripes: [UIView] = []
    var stripeHeight: CGFloat = 101.0
    var yOffset: CGFloat = 0.0
    private let carImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCarImageView()
        setupArrowButtons()
        view.backgroundColor = UIColor.lightGray

        let stripeWidth: CGFloat = 15.0
        let stripeSpacing: CGFloat = 100.0
        let stripeCount = 4
        let rowSpacing: CGFloat = 40.0
        let rowCount = 100

        let totalHeight = CGFloat(rowCount) * stripeHeight + CGFloat(rowCount - 1) * rowSpacing
        let xOffset = (view.frame.width - CGFloat(stripeCount) * stripeWidth - CGFloat(stripeCount - 1) * stripeSpacing) / 2.0
        yOffset = (view.frame.height - totalHeight) / 2.0

        for row in 0..<(rowCount + 2) {
            let y = yOffset + CGFloat(row) * (stripeHeight + rowSpacing)
            for i in 0..<stripeCount {
                let x = xOffset + CGFloat(i) * (stripeWidth + stripeSpacing)
                let stripe = UIView(frame: CGRect(x: x, y: y, width: stripeWidth, height: stripeHeight))
                stripe.backgroundColor = UIColor.white
                view.addSubview(stripe)
                stripes.append(stripe)
            }
        }
        let animationDuration: TimeInterval = 5
        animateStripes(withDuration: animationDuration)
    }

    func animateStripes(withDuration duration: TimeInterval) {
        let stripeDistance = view.frame.height + yOffset

        UIView.animate(withDuration: duration, delay: 0, options: [.curveLinear, .repeat], animations: {
            for stripe in self.stripes {
                stripe.frame.origin.y -= stripeDistance
            }
        }, completion: { _ in
            for stripe in self.stripes {
                stripe.frame.origin.y = self.yOffset - self.stripeHeight
            }
            self.animateStripes(withDuration: duration)
        })
    }
    
    private func setupCarImageView() {
        carImageView.image = UIImage(named: "car")
        carImageView.contentMode = .scaleAspectFit
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(carImageView)
        
        NSLayoutConstraint.activate([
            carImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -143),
            carImageView.widthAnchor.constraint(equalToConstant: 50),
            carImageView.heightAnchor.constraint(equalToConstant: 103),
            carImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setupArrowButtons() {
        let leftArrowButton = UIButton(type: .system)
        leftArrowButton.setImage(UIImage(named: "arrowLeft"), for: .normal)
        leftArrowButton.tintColor = .black
        leftArrowButton.translatesAutoresizingMaskIntoConstraints = false
        leftArrowButton.addTarget(self, action: #selector(leftArrowButtonTapped), for: .touchUpInside)
        view.addSubview(leftArrowButton)
        
        let rightArrowButton = UIButton(type: .system)
        rightArrowButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        rightArrowButton.tintColor = .black
        rightArrowButton.translatesAutoresizingMaskIntoConstraints = false
        rightArrowButton.addTarget(self, action: #selector(rightArrowButtonTapped), for: .touchUpInside)
        view.addSubview(rightArrowButton)
        
        NSLayoutConstraint.activate([
            leftArrowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.bounds.height * -0.035),
            leftArrowButton.widthAnchor.constraint(equalToConstant: 90),
            leftArrowButton.heightAnchor.constraint(equalToConstant: 90),
            leftArrowButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            rightArrowButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: view.bounds.height * -0.035),
            rightArrowButton.widthAnchor.constraint(equalToConstant: 90),
            rightArrowButton.heightAnchor.constraint(equalToConstant: 90),
            rightArrowButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25)
        ])
    }
    
    @objc private func leftArrowButtonTapped() {
        moveCarHorizontally(direction: .left)
    }
    
    @objc private func rightArrowButtonTapped() {
        moveCarHorizontally(direction: .right)
    }
    
    private func moveCarHorizontally(direction: Direction) {
        let screenWidth = view.bounds.width
        let carWidth = carImageView.bounds.width
        let barrierWidth: CGFloat = 75
        
        let minX = barrierWidth
        let maxX = screenWidth - carWidth - barrierWidth
        
        var newX: CGFloat
        
        switch direction {
        case .left:
            newX = max(carImageView.frame.origin.x - 115, CGFloat(minX))
        case .right:
            newX = min(carImageView.frame.origin.x + 115, CGFloat(maxX))
        }
        
        newX = min(maxX, max(minX, newX))
           
           UIView.animate(withDuration: 0.2, animations: {
               self.carImageView.frame.origin = CGPoint(x: newX, y: self.carImageView.frame.origin.y)
           })
    }
}

enum Direction {
   case left
    case right
}
