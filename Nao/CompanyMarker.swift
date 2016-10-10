//
//  CompanyMarker.swift
//  Nao
//
//  Created by Procesos on 2/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit
import GoogleMaps

class CompanyMarker: GMSMarker {
    
    let company: Company
    
    init(company: Company) {
        
        self.company = company
        super.init()
        
        position = CLLocationCoordinate2DMake(company.latitude!, company.longitude!)
        title = company.name
        snippet = company.detail
        appearAnimation = kGMSMarkerAnimationPop
        icon = company.iconImage
    }
}

