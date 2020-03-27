//
//  Contrains.swift
//  SampleMyFriends
//
//  Created by apple on 30/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?,centerX: NSLayoutXAxisAnchor?,centerY: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, center: (CenterX:Int, CenterY:Int)) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if let centerX = centerX {
            anchoredConstraints.centerX = centerXAnchor.constraint(equalTo: centerX, constant: CGFloat(center.CenterX))
        }
        
        if let centerY = centerY {
            anchoredConstraints.centerY = centerYAnchor.constraint(equalTo: centerY, constant: CGFloat(center.CenterY))
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing,anchoredConstraints.centerX,anchoredConstraints.centerY, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
}

//MARK:- safeArea
extension UIView {
    //MARK: safeTopAnchor
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    //MARK: safeLeftAnchor
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    //MARK: safeRightAnchor
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    //MARK: safeBottomAnchor
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, centerX, centerY, width, height: NSLayoutConstraint?
}
