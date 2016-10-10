//
//  ImageBackgroundView.swift
//  Culture
//
//  Created by J on 3/23/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

class ImageBackgroundView: UIView {

    @IBInspectable var backgroundImage : UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.contents = backgroundImage!.CGImage
        
    }
}
