//
//  ViewController.swift
//  TapTheBalls
//
//  Created by Aleksandra Konopka on 23/05/2019.
//  Copyright © 2019 Aleksandra Konopka. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spawnTheBall()
    }
    
    @objc func onceTapped(_ tap: UITapGestureRecognizer) {
        animation(myBall: self.view.subviews[0], scale: 2, alpha: 0.0, duration: 0.3)
        self.view.subviews[0].removeFromSuperview()
        spawnTheBall()
    }
    
    private func animation(myBall : UIView, scale: CGFloat, alpha: CGFloat, duration: TimeInterval)
    {
        UIView.animate(withDuration: duration, animations: {
            myBall.alpha = alpha
            myBall.transform = CGAffineTransform(scaleX: scale, y: scale)
        })
    }
    
    func spawnTheBall()
    {
        let randX = getRandomNumber(to: Int(UIScreen.main.bounds.width), ballSize: 50 , safeArea: 10)
        let randY = getRandomNumber(to: Int(UIScreen.main.bounds.height), ballSize: 50, safeArea: 0)
        let spawnedView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        spawnedView.center = CGPoint(x: randX, y: randY)
        spawnedView.backgroundColor = UIColor.randomBrightColor()
        spawnedView.layer.cornerRadius = 50 * 0.5
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(onceTapped))
        oneTap.delegate = self
        spawnedView.addGestureRecognizer(oneTap)
        view.addSubview(spawnedView)
    }
    
    func getRandomNumber(to: Int, ballSize: Int, safeArea: Int)->Int
    {
        return Int.random(in: 0 ... to - ballSize - safeArea)
    }
    
}

extension CGFloat {
    static func random() -> CGFloat {
        return random(min: 0.0, max: 1.0)
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(max > min)
        return min + ((max - min) * CGFloat(arc4random()) / CGFloat(UInt32.max))
    }
}

extension UIColor {
    static func randomBrightColor() -> UIColor {
        return UIColor(hue: .random(),
                       saturation: .random(min: 0.5, max: 1.0),
                       brightness: .random(min: 0.7, max: 1.0),
                       alpha: 1.0)
    }
}
