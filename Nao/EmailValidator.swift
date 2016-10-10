//
//  EmailValidator.swift
//  Culture
//
//  Created by J on 3/20/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation

class EmailValidator {
    
    var validate = true
    
    class func validate(value:String?) -> Bool {
    
        let emailRegEx = "^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluateWithObject(value)
    }
}