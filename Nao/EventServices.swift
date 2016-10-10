//
//  EventServices.swift
//  Emogi Fox
//
//  Created by Luis on 8/08/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit


class EventServices {
    
    static let allCompanyPath = "company.php?"
    static let allEventsPath = "categories.php"

    
    static func getAllEvents( completionHandler:(categories:[Category]?, error:NSError?) -> Void) {
        
        let request = RequestBuilder.GET(path: allEventsPath)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            
            var userCategories = [Category]()
            
            if let error = error {
                completionHandler(categories: nil, error: error)
            }
                
            else {
                
                if let jsonObjectArray = jsonObject as? [[String:AnyObject]] {
                    
                    for userComment in jsonObjectArray {
                        
                        userCategories.append(Category(jsonObject: userComment))
                    }
                    
                    completionHandler(categories: userCategories, error: nil)
                    
                }

                else {
                    completionHandler(categories: nil, error: NSError.defaultErrorFromServer())
                }
            }
        }
    }
    
    static func getAllCompanys( completionHandler:(categories:[Company]?, error:NSError?) -> Void) {
        
      
        let GetCommentsFromEvent = allCompanyPath + "id=\("1")&cat=\("1")&fav=1"
        
        let request = RequestBuilder.GET(path: GetCommentsFromEvent)
        
        NetworkManager().dataTaskWithRequest(request) { (jsonObject, error) -> Void in
            
            var userCompany = [Company]()
            
            if let error = error {
                completionHandler(categories: nil, error: error)
            }
                
            else {
                
                if let jsonObjectArray = jsonObject as? [[String:AnyObject]] {
                    
                    for userComment in jsonObjectArray {
                        
                        userCompany.append(Company(jsonObject: userComment))
                    }
                    
                    completionHandler(categories: userCompany, error: nil)
                    
                }
                    
                else {
                    completionHandler(categories: nil, error: NSError.defaultErrorFromServer())
                }
            }
        }
    }
    
    
    
}
