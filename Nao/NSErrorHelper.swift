//
//  NSErrorHelper.swift
//  Culture
//
//  Created by J on 3/20/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation

extension  NSError {
    
    static func defaultError() -> NSError {
        return errorWithMessage("Error")
    }
    
    static func defaultErrorFromServer() -> NSError {
        return errorWithMessage("Error inesperado del servicio.")
    }
    
    static func errorWithMessage(errorMessage:String) -> NSError {
        return errorWithMessage(errorMessage, code: -999)
    }
    
    static func errorWithMessage(errorMessage:String, code:Int) -> NSError {
        return NSError(domain: "EmogiFoxError", code:code, userInfo: [NSLocalizedDescriptionKey:errorMessage])
    }
    
    static func errorWithMessageFromJSONObject(JSONObject:[String:AnyObject]) -> NSError? {
        
        if let statusCode = JSONObject["statusCode"] {
            
            if statusCode as! Int == 200 {
                return nil
            }
                
            else {
                return errorWithMessage(JSONObject["message"] as! String, code: statusCode as! Int)
            }
        }
        
        else {
            return nil
        }
        
    }
}