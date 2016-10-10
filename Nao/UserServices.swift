//
//  UserServices.swift
//  Nao
//
//  Created by Procesos on 27/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import Foundation


class UserServices {
    
    static let emailUserPath = "login.php?"
    static let loginSocialPath = "login_social.php?"
    static let registerPath = "register.php?"
    
    //MARK: Login with email and password.
    static func login(email:String, password:String, completionHandler:(user: User!, error: NSError?) -> Void) {
        
        let GetCommentsFromEvent = emailUserPath + "mail=\(email)&pass=\(password)"
        
        let request = RequestBuilder.GET(path: GetCommentsFromEvent)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            if (error != nil) {
                completionHandler(user: nil, error: error)
            }
                
            else {
                
                if let jsonDictionary = jsonObject as? [String:AnyObject]  {
                    
                    if let error = jsonDictionary["error"] as? String {
                      
                        let error = NSError(domain: "", code: -42, userInfo: [NSLocalizedDescriptionKey: error])
    
                        completionHandler(user: nil, error: error)
                    }else {
                        
                        let user = User(jsonObject: jsonDictionary)
                        completionHandler(user: user, error: nil)
                    }
                }
                else {
                    completionHandler(user: nil, error: NSError.defaultError())
                }
            }
        }
    }
    
    static func loginSocial(socialId:String, completionHandler:(user: User!, error: NSError?) -> Void) {
        
        let GetCommentsFromEvent = loginSocialPath + "social_id=\(socialId)"
        
        let request = RequestBuilder.GET(path: GetCommentsFromEvent)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            if (error != nil) {
                completionHandler(user: nil, error: error)
            }
                
            else {
                
                if let jsonDictionary = jsonObject as? [String:AnyObject]  {
                    
                    if let error = jsonDictionary["error"] as? String {
                        
                        let error = NSError(domain: "", code: -42, userInfo: [NSLocalizedDescriptionKey: error])
                        
                        completionHandler(user: nil, error: error)
                    }else {
                        
                        let user = User(jsonObject: jsonDictionary)
                        completionHandler(user: user, error: nil)
                    }
                }
                else {
                    completionHandler(user: nil, error: NSError.defaultError())
                }
            }
        }
    }

    static func registerUser(name:String, mail:String, pass:String, sexo:Int, fec:String,
                             dir:String, sub_cat:String, companies_id:String, social_id:String, id:Int, completionHandler:(user: User!, error: NSError?) -> Void) {
        
        let GetCommentsFromEvent = registerPath + "name=\(name)&mail=\(mail)&pass=\(pass)&sexo=\(sexo)&fec=\(fec)&dir=\(dir)&sub_cat=\(sub_cat)&companies_id=\(companies_id)&social_id=\(social_id)&id=\(id)"
        
        let request = RequestBuilder.GET(path: GetCommentsFromEvent)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            if (error != nil) {
                completionHandler(user: nil, error: error)
            }
                
            else {
                
                if let jsonDictionary = jsonObject as? [String:AnyObject]  {
                    
                    if let error = jsonDictionary["error"] as? String {
                        
                        let error = NSError(domain: "", code: -42, userInfo: [NSLocalizedDescriptionKey: error])
                        
                        completionHandler(user: nil, error: error)
                    }else {
                        
                        let user = User(jsonObject: jsonDictionary)
                        completionHandler(user: user, error: nil)
                    }
                }
                else {
                    completionHandler(user: nil, error: NSError.defaultError())
                }
            }
        }
    }
    
}
