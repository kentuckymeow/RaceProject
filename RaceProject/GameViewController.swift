//
//  GameViewController.swift
//  RaceProject
//
//  Created by Arseni Khatsuk on 06.06.2023.
//

import UIKit
import CoreGraphics

class GameViewController: UIViewController {
    var stripes: [UIView] = []
    var stripeHeight: CGFloat = 101.0
    var yOffset: CGFloat = 0.0


    override func viewDidLoad() {
        super.viewDidLoad()

        // Создаем прямоугольник для трассы
        let roadView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        roadView.backgroundColor = UIColor.lightGray
        view.addSubview(roadView)

        // Создаем полосы на трассе
        let stripeWidth: CGFloat = 15.0
        let stripeSpacing: CGFloat = 100.0
        let stripeCount = 3
        let rowSpacing: CGFloat = 103.0
        let rowCount = 100

        let totalHeight = CGFloat(rowCount) * stripeHeight + CGFloat(rowCount - 1) * rowSpacing
        let xOffset = (view.frame.width - CGFloat(stripeCount) * stripeWidth - CGFloat(stripeCount - 1) * stripeSpacing) / 2.0
        yOffset = (view.frame.height - totalHeight) / 2.0

        for row in 0..<(rowCount + 2) { // Добавляем две дополнительные строки
            let y = yOffset + CGFloat(row) * (stripeHeight + rowSpacing)

            for i in 0..<stripeCount {
                let x = xOffset + CGFloat(i) * (stripeWidth + stripeSpacing)

                let stripe = UIView(frame: CGRect(x: x, y: y, width: stripeWidth, height: stripeHeight))
                stripe.backgroundColor = UIColor.white
                roadView.addSubview(stripe)

                stripes.append(stripe)
            }
        }

        // Анимируем движение полос
        let animationDuration: TimeInterval = 10

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
}

