//
//  Company.swift
//  Nao
//
//  Created by Procesos on 1/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class Company: NSObject {
    
    struct CompanyJSONKeys {
        static let idKey = "id"
        static let cat = "cat"
        static let name = "name"
        static let detail = "detail"
        static let logo = "logo"
        static let banner = "banner"
        static let lat = "lat"
        static let lon = "lon"
        static let marker = "marker"
        static let phone = "phone"
        static let mail = "mail"
        static let address = "address"
    }
    
    var Id: Int!
    var name: String!
    var detail: String!
    var logo: String?
    var banner: String!
    var latitude: Double?
    var longitude: Double?
    var marker: String?
    var phone: String?
    var mail: String?
    var address: String?
    var iconImage: UIImage?
    var alredyInvited = false
    
    init(jsonObject:[String:AnyObject]) {
        
        Id = jsonObject[CompanyJSONKeys.idKey] as! Int
        name = jsonObject[CompanyJSONKeys.name] as! String
        detail = jsonObject[CompanyJSONKeys.detail] as! String
        banner = jsonObject[CompanyJSONKeys.banner] as! String
        
        if let marker = jsonObject[CompanyJSONKeys.marker] as? String {
            self.marker = marker
        }
        
        if let phone = jsonObject[CompanyJSONKeys.phone] as? String {
            self.phone = phone
        }
        
        if let mail = jsonObject[CompanyJSONKeys.mail] as? String {
            self.mail = mail
        }
        
        if let address = jsonObject[CompanyJSONKeys.address] as? String {
            self.address = address
        }
        
        if let latitude = jsonObject[CompanyJSONKeys.lat] as? Double {
            self.latitude = latitude
        }
        
        if let longitude = jsonObject[CompanyJSONKeys.lon] as? Double {
            self.longitude = longitude
        }
        
        if let logo = jsonObject[CompanyJSONKeys.logo] as? String {
            self.logo = logo
            
            let imagen = UIImageView()
            imagen.contentMode = .ScaleAspectFit
            imagen.sd_setImageWithURL(NSURL(string: ("http://ipfcom.org/grupon/" + self.logo!)), placeholderImage: UIImage(named: "locationPin"))
            sleep(1)  // time in seconds
            iconImage = imagen.scaleImage(imagen.image!, toSize: CGSizeMake(20, 20))
            
            /*
            let url = NSURL(string: ("http://ipfcom.org/grupon/" + self.logo!))
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
                dispatch_async(dispatch_get_main_queue(), {
                    self.iconImage = UIImage(data: data!)
                });
            }*/
        }
        
    }

}


extension UIImageView {
    
    func scaleImage(image: UIImage, toSize newSize: CGSize) -> (UIImage) {
        let newRect = CGRectIntegral(CGRectMake(0,0, newSize.width, newSize.height))
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetInterpolationQuality(context!, .High)
        let flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height)
        CGContextConcatCTM(context!, flipVertical)
        CGContextDrawImage(context!, newRect, image.CGImage!)
        let newImage = UIImage(CGImage: CGBitmapContextCreateImage(context!)!)
        UIGraphicsEndImageContext()
        return newImage
    }
}
