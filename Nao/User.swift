//
//  User
//  Culture
//
//  Created by J on 3/17/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
    
    var id: Int!
    var name : String!
    var email : String?
    var sex: Int?
    var date: String!
    var dir: String!
    var pic: String!
    
    static let didLoginNotification = "UserDidLogin"
    static let didLogoutNotification = "UserDidLogout"
    static let didUpdateCurrentUserNotification = "UserDidUpdateCurrentUser"

    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("User")

    struct UserJSONKeys {
        static let idKey = "id"
        static let name = "name"
        static let email = "mail"
        static let sex = "sex"
        static let date = "date"
        static let dir = "dir"
        static let pic = "pic"
    }
    
    init(jsonObject: [String : AnyObject]) {
        
        id = jsonObject[UserJSONKeys.idKey] as! Int
        name = jsonObject[UserJSONKeys.name] as! String
        
        if let email = jsonObject[UserJSONKeys.email] as? String {
            self.email = email
        }
        
        if let sex = jsonObject[UserJSONKeys.sex] as? Int {
            self.sex = sex
        }
        
        date = jsonObject[UserJSONKeys.date] as! String
        dir = jsonObject[UserJSONKeys.dir] as! String
        pic = jsonObject[UserJSONKeys.pic] as! String
        
    }
    
    // MARK: NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeInteger(id, forKey: UserJSONKeys.idKey)
        aCoder.encodeObject(name, forKey: UserJSONKeys.name)
        aCoder.encodeObject(email, forKey: UserJSONKeys.email)
        aCoder.encodeObject(date, forKey: UserJSONKeys.date)
        if sex != nil {
            aCoder.encodeInteger(sex!, forKey: UserJSONKeys.sex)
        }
        
        aCoder.encodeObject(dir, forKey: UserJSONKeys.dir)
        aCoder.encodeObject(pic, forKey: UserJSONKeys.pic)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init()
        id = aDecoder.decodeIntegerForKey(UserJSONKeys.idKey) 
        name = aDecoder.decodeObjectForKey(UserJSONKeys.name) as! String
        date = aDecoder.decodeObjectForKey(UserJSONKeys.date) as! String
        
        if let email = aDecoder.decodeObjectForKey(UserJSONKeys.email) as? String {
            self.email = email
        }
        
        if sex != nil {
            self.sex = aDecoder.decodeIntegerForKey(UserJSONKeys.sex)
        }
        
        dir = aDecoder.decodeObjectForKey(UserJSONKeys.dir) as! String
        pic = aDecoder.decodeObjectForKey(UserJSONKeys.pic) as! String
        
    }
}

extension User {
    
    func displayName() -> String {
        
        return self.name
    }
    
    func hasImage() -> String {
        
        return "http://ipfcom.org/grupon/" + self.pic
    }
}
