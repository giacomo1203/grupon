//
//  ShowAlertController.swift
//  Culture
//
//  Created by J on 3/19/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showError(error:NSError) {
        
        showAlert(error.localizedDescription)
    }
    
    func showAlert(message:String) {
        
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil);
    }
}
