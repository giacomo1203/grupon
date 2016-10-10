//
//  EditProfileVC.swift
//  Nao
//
//  Created by Procesos on 1/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class EditProfileVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var profileImageView: ProfileImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var txtProfileName: UITextField!
    @IBOutlet weak var txtProfileEmail: UITextField!
    @IBOutlet weak var txtProfileBirthday: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "NAO"
        changeProfile()
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        
        // Do any additional setup after loading the view.
    }
    
    func changeProfile() {
        
        if UserManager.hasCurrentUser() {
            
            txtProfileName.text = UserManager.sharedInstance.currentUser!.displayName()
            txtProfileEmail.text = UserManager.sharedInstance.currentUser!.email
            txtProfileBirthday.text = UserManager.sharedInstance.currentUser!.email
            
            profileName.text = UserManager.sharedInstance.currentUser!.displayName()
           
            profileImageView.sd_setImageWithURL(NSURL(string: UserManager.sharedInstance.currentUser!.hasImage()), placeholderImage: UIImage(named: "userPlaceholder"))
        }
            
        else {
            
            profileName.text = "Ingresar"
            profileImageView.image = UIImage(named: "NonLoggedUser")
        }
    }
    
    @IBAction func onClickInput(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: "Seguro deseas salir?", preferredStyle: .ActionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let destroyAction = UIAlertAction(title: "Salir", style: .Destructive) { (action) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                self.showLoginScreen()
                UserManager.deleteUser()
            })
        }
        
        alertController.addAction(destroyAction)
        
        self.presentViewController(alertController, animated:true, completion: nil)
    }
    
    func showLoginScreen() {
        
        let loginStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let navigationViewController = loginStoryboard.instantiateViewControllerWithIdentifier("LoginNavController") as! TransparentNavigationController
        let loginViewController = loginStoryboard.instantiateViewControllerWithIdentifier("LoginVC") as! LoginVC
        navigationViewController.setViewControllers([loginViewController], animated: true)
        self.showViewController(navigationViewController, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
