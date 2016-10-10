//
//  CreateAccountValidator.swift
//  Culture
//
//  Created by J on 3/20/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation


class CreateAccountValidator {
    
    let firstName: String?
    let lastName: String?
    let email: String?
    let password: String?
    let repeatedPassword: String?
    
    var valid = true
    
    init(firstName:String?, lastName:String?, email:String?, password:String?, repeatedPassword:String?) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.repeatedPassword = repeatedPassword
    }
    
    
    func validate() {
        
        
    }
    
    class func containsSpecialChars(input: String) -> Bool {
        let characterset = NSCharacterSet(charactersInString: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789")
        if input.rangeOfCharacterFromSet(characterset.invertedSet) != nil {
            return true
        }else {
            return false
        }
    }
    
    class func containsOnlyLetters(input: String) -> Bool {
        for chr in input.characters {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
                return false
            }
        }
        return true
    }
    
}