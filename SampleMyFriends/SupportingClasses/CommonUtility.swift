//
//  CommonUtility.swift
//  SampleMyFriends
//
//  Created by Others on 30/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

//MARK:- UILabel
extension UILabel {
    //MARK: changeFrame
    func changeFrame(toOriginX newOriginX: CGFloat,
                            toOriginY newOriginY: CGFloat,
                            toWidth newWidth: CGFloat,
                            toHeight newHeight: CGFloat,
                            font: UIFont,
                            alignment: NSTextAlignment,
                            duration: TimeInterval) {
        let oldFrame = self.frame
        let newFrame = CGRect(x: newOriginX, y: newOriginY, width: newWidth, height: newHeight)

        let translation = CGAffineTransform(translationX: newFrame.midX - oldFrame.midX,
                                            y: newFrame.midY - oldFrame.midY)
        let scaling = CGAffineTransform(scaleX: newFrame.width / oldFrame.width,
                                        y: newFrame.height / oldFrame.height)

        let transform = scaling.concatenating(translation)

        UIView.animate(withDuration: duration, animations: {
            self.transform = transform
            self.font = font
            self.textAlignment = alignment
        }) { _ in
            self.transform = .identity
            self.frame = newFrame
        }
    }
}

//MARK:- UIFont
extension UIFont {
    class func setAppFont(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "Roboto-Regular", size: size)!
    }
    
    class func setAppFontBold(_ size:CGFloat)->(UIFont) {
        return UIFont(name: "Roboto-Medium", size: size)!
    }
    
    
}

//MARK:- UIView
extension UIView {
    //MARK: animateView
    func animateView(_ subtype: String, _ duration: Float = 0.5 ,completion: @escaping()->()){
        let transition:CATransition = CATransition()
        transition.duration = CFTimeInterval(duration)
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype(rawValue: subtype)
        self.layer.add(transition, forKey: kCATransition)
        completion()
    }
    
    //MARK: roundCorners
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

//MARK:- UIViewController
extension UIViewController {
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
