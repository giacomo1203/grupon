//
//  ProfileImageView.swift
//  Culture
//
//  Created by J on 3/27/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

protocol ProfileImageViewDelegate {
    func profileImageViewWasTouch(view:ProfileImageView)
}

class ProfileImageView: UIImageView {
    
    var delegate: ProfileImageViewDelegate?
    @IBInspectable var colorBorder: UIColor? {
        
        didSet {
            self.layer.borderColor = colorBorder!.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layoutIfNeeded()
        self.clipsToBounds = true
        self.contentMode = .ScaleAspectFill
        let radius = min(CGRectGetHeight(self.frame), CGRectGetWidth(self.frame) / 2.0)
        self.layer.cornerRadius = radius
        self.userInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ProfileImageView.profileImageViewWasTouch))
        self.addGestureRecognizer(gesture)
    }
    
    
    func profileImageViewWasTouch() {
        self.delegate?.profileImageViewWasTouch(self)
    }

}
