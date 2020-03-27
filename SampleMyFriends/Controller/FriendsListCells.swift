//
//  FriendsListCells.swift
//  SampleMyFriends
//
//  Created by Others on 01/02/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class FriendsListCells: UITableViewCell {
    
    //titleLbl
    let titleLbl:UILabel = {
        let label = UILabel()
        label.font = UIFont.setAppFont(16)
        label.textAlignment = .natural
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //distanceLbl
    let distanceLbl:UILabel = {
        let label = UILabel()
        label.font = UIFont.setAppFont(16)
        label.textAlignment = .natural
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    //profileImg
    let profileImg:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //seperatorLbl
    let seperatorLbl:UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9371728301, green: 0.9373074174, blue: 0.9371433258, alpha: 1)
        return label
    }()
    
    
    //MARK: reuseIdentifier
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //profileImg
        self.addSubview(profileImg)
        profileImg.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: self.centerYAnchor, padding: UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 0), size: CGSize(width: 60, height: 60), center: (0,0))
        
        //titleLbl
        self.addSubview(titleLbl)
        titleLbl.anchor(top: nil, leading: profileImg.trailingAnchor, bottom: self.centerYAnchor, trailing: self.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 23), center: (0,0))
        
        //distanceLbl
        self.addSubview(distanceLbl)
        distanceLbl.anchor(top: self.centerYAnchor, leading: profileImg.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 23), center: (0,0))
        
        //seperatorLbl
        self.addSubview(seperatorLbl)
        seperatorLbl.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8), size: CGSize(width: 0, height: 1), center: (0,0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
