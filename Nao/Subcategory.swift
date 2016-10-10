//
//  Subcategory.swift
//  Culture
//
//  Created by J on 3/24/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import UIKit

class Subcategory: NSObject {

    struct SubCategoryJSONKeys {
        static let subcategoryID = "id"
        static let name = "name"
        static let icon = "icon"
    }
    
    var subcategoryID: Int?
    var name: String?
    var icon: String?
    var alredyInvited = false
    
    init(jsonObject:[String:AnyObject]) {
        
        if let subcategoryID = jsonObject[SubCategoryJSONKeys.subcategoryID] as? Int {
            self.subcategoryID = subcategoryID
        }
    
        if let name = jsonObject[SubCategoryJSONKeys.name] as? String {
            self.name = name
        }
        
        if let icon = jsonObject[SubCategoryJSONKeys.icon] as? String {
            self.icon = icon
        }
    
    }
}
