//
//  UserManager
//  Culture
//
//  Created by J on 3/17/16.
//  Copyright © 2016 LIMAAPP E.I.R.L. All rights reserved.
//

import Foundation

class UserManager {
    
    static let sharedInstance = UserManager()
    
    var currentUser: User? {
        didSet {
            if currentUser != nil {
                NSNotificationCenter.defaultCenter().postNotificationName(User.didLoginNotification, object: nil)
            }
        }
    }
    
    private init(){
        currentUser = NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL!.path!) as? User
    }
    
    static func hasCurrentUser() -> Bool{
        
        if sharedInstance.currentUser != nil {
            return true
        }else{
            return false
        }
    }
    
    static func getInformationFromUser() -> User{
        return NSKeyedUnarchiver.unarchiveObjectWithFile(User.ArchiveURL!.path!) as! User
    }
    
    static func saveUser() -> Bool {
        return NSKeyedArchiver.archiveRootObject(sharedInstance.currentUser!, toFile: User.ArchiveURL!.path!)
    }
    
    static func deleteUser() {
        
        sharedInstance.currentUser = nil
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(User.ArchiveURL!.path!)
        }
        
        catch let error as NSError {
            print("Failed to remove user: \(error)")
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.didLogoutNotification, object: nil)
    }
}
