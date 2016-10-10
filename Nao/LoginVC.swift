//
//  LoginVC.swift
//  Nao
//
//  Created by Procesos on 19/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var txtUser: UITextField!
    @IBOutlet weak var txtPass: UITextField!
    var email : String?
    var loadingLoginButton = false
    var loadingFacebookControl = false
    var loginView = LoginAlertView()
    var signInButton = GIDSignInButton()
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var buttonFacebook: UIButton!
    @IBOutlet weak var buttonGPlus: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn .sharedInstance().signInSilently()
        
        signInButton.frame = CGRectMake(0, 100, 50, 100)
        signInButton.hidden = true
        self.view .addSubview(signInButton)
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
       
        buttonLogin.addTarget(self, action: #selector(LoginVC.loginEmailPass(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        buttonFacebook.addTarget(self, action: #selector(LoginVC.loginFacebook(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        buttonGPlus.addTarget(self, action: #selector(LoginVC.loginGPlus(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func createLoginView() {
        loginView =  NSBundle.mainBundle().loadNibNamed("LoginAlertView", owner: self, options: nil)![0] as! LoginAlertView
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.loginInformationLabel.text = ""
        view.addSubview(loginView)
        self.loginView.alpha = 0.0
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[loginView]-(0)-|", options: [], metrics: nil, views: ["loginView": loginView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[loginView]-(0)-|", options: [], metrics: nil, views: ["loginView": loginView]))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loginWithFacebook() {
        
        self.loadingFacebookControl = true
        
        let login = FBSDKLoginManager()
        login.logOut()
        login.logInWithReadPermissions(["public_profile", "email"], fromViewController: self) { (result, error) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                if let error = error {
                    self.loadingFacebookControl = false
                    self.showError(error)
                }
                    
                else if result.isCancelled {
                    self.loadingFacebookControl = false
                }
                    
                else {
                    
                    let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me?fields=id,first_name,last_name,email", parameters: nil)
                    graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
                        
                        NSOperationQueue.mainQueue().addOperationWithBlock {
                            
                            if ((error) != nil) {
                                self.showAlert("Hubo un problema. Intenta ingresar con Facebook nuevamente.")
                            }
                                
                            else {
                                
                                let urlImage = "http://graph.facebook.com/" + (result["id"] as! String) + "/picture?width=200"
                                
                                self.email = result["email"] as? String
                                
                                if self.email == nil {
                                    self.email = ""
                                }
                                NSUserDefaults.standardUserDefaults().setObject(urlImage, forKey: "urlPhoto")
                                NSUserDefaults.standardUserDefaults().setObject(result["first_name"] as! String, forKey: "first_name")
                                NSUserDefaults.standardUserDefaults().setObject(result["last_name"] as! String, forKey: "last_name")
                                NSUserDefaults.standardUserDefaults().setObject(self.email!, forKey: "mail")
                                NSUserDefaults.standardUserDefaults().setObject(String(result["id"] as! String), forKey: "pass")
                                
                                UserServices.loginSocial(result["id"] as! String) { (user, error) -> Void in
                                    
                                    NSOperationQueue.mainQueue().addOperationWithBlock {
                                        
                                        if error != nil {
                                            dispatch_async(dispatch_get_main_queue()) {
                                                // update some UI
                                                self.performSegueWithIdentifier("toRegisterSocialInformation", sender: self)
                                            }
                                        }else {
                                            self.saveUserData(user)
                                        }
                                    }
                                }
                            }
                        }
                    })
                }
            }
        }
    }
    
    func loginWithEmailPass() {
        if !EmailValidator.validate(txtUser.text!) {
            showAlert("Debes ingresar un e-mail válido. Por favor ingrésalo nuevamente.")
            return
        }
        
        if CreateAccountValidator.containsSpecialChars(txtPass.text!) {
            showAlert("Tu contraseña contiene carácteres no permitidos. Por favor ingrésala nuevamente.")
            return
        }
        
        if let string = txtPass.text where string.isEmpty {
            showAlert("Ingrese un password")
            return
        }
        
        UserServices.login(txtUser.text!, password: txtPass.text!) { (user, error) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                if error != nil {
                    self.showError(error!)
                }else {
                    self.saveUserData(user)
                }
            }
        }
    }
    
    private func saveUserData(user: User!){
        
        UserManager.sharedInstance.currentUser = user
        UserManager.saveUser()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func loginEmailPass(Sender: UIButton!) {
        loginWithEmailPass()
    }
    
    @objc func loginFacebook(Sender: UIButton!) {
        loginWithFacebook()
    }
    
    @objc func loginGPlus(Sender: UIButton!) {
        signInButton.sendActionsForControlEvents(.TouchUpInside)
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

extension LoginVC: GIDSignInDelegate, GIDSignInUIDelegate {
    
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        
        if GIDSignIn.sharedInstance().currentUser.authentication != nil {
            // Perform any operations on signed in user here.
            
            let userID = user.userID
            let idToken = user.authentication.idToken
            let name = user.profile.name
            let email = user.profile.email
            
            print("userID \(userID)\n idToken \(idToken)\n name \(name)\n email \(email)")
        
            NSUserDefaults.standardUserDefaults().setObject(user.profile.imageURLWithDimension(300).absoluteString!, forKey: "urlPhoto")
            NSUserDefaults.standardUserDefaults().setObject(name, forKey: "name")
            NSUserDefaults.standardUserDefaults().setObject(email, forKey: "mail")
            NSUserDefaults.standardUserDefaults().setObject(userID, forKey: "pass")
            
            if GIDSignIn.sharedInstance().currentUser.profile.hasImage {
                
                let imageURL = user.profile.imageURLWithDimension(300)
                print(imageURL.absoluteString!)
            }
            
            UserServices.loginSocial(user.userID) { (user, error) in
                
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    
                    if error != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            // update some UI
                            self.performSegueWithIdentifier("toRegisterSocialInformation", sender: self)
                        }
                    }else {
                        self.saveUserData(user)
                    }
                }
            }
        }
        
    }
    
    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user: GIDGoogleUser!, withError error: NSError!) {
        
        GIDSignIn.sharedInstance().disconnect()
    }
    
}

extension LoginVC {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toRegisterSocialInformation" {
            
            let eventDetailsViewController = segue.destinationViewController as! ListCatVC
        }
    }
    
}
