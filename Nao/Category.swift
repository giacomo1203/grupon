//
//  Category.swift
//  Nao
//
//  Created by Procesos on 28/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    struct CategoryJSONKeys {
        static let idKey = "id"
        static let name = "name"
        static let icono = "icon"
        static let sub = "sub"
    }
    
    var Id: Int!
    var name: String!
    var icono: String!
    var alredyInvited = false
    var subcategorys = [Subcategory]()
    
    init(jsonObject: [String : AnyObject]) {
        
        Id = jsonObject[CategoryJSONKeys.idKey] as! Int
        name = jsonObject[CategoryJSONKeys.name] as! String
        icono = jsonObject[CategoryJSONKeys.icono] as! String
        
        if let eventsArray = jsonObject[CategoryJSONKeys.sub] {
            
            for event in (eventsArray as! [[String: AnyObject]]) {
                subcategorys.append(Subcategory(jsonObject: event))
            }
        }
        
    }
}
