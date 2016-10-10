//
//  RegisterVC.swift
//  Nao
//
//  Created by Procesos on 19/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {
    
    @IBOutlet weak var txtUserEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtUserPass: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(RegisterVC.popToViewController))
        
        button.addTarget(self, action: #selector(RegisterVC.register(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func register(Sender: UIButton!) {
        
        if !EmailValidator.validate(txtUserEmail.text!) {
            showAlert("Debes ingresar un e-mail válido. Por favor ingrésalo nuevamente.")
            return
        }
        
        if CreateAccountValidator.containsSpecialChars(txtUserPass.text!) {
            showAlert("Tu contraseña contiene carácteres no permitidos. Por favor ingrésala nuevamente.")
            return
        }
        
        if let string = txtUserPass.text where string.isEmpty {
            showAlert("Ingrese un password")
            return
        }
        
        if let string = txtUserName.text where string.isEmpty {
            showAlert("Ingrese un nombre")
            return
        }
        
        NSUserDefaults.standardUserDefaults().setObject(txtUserName.text!, forKey: "name")
        NSUserDefaults.standardUserDefaults().setObject(txtUserEmail.text!, forKey: "mail")
        NSUserDefaults.standardUserDefaults().setObject(txtUserPass.text!, forKey: "pass")
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func popToViewController() {
        self.navigationController?.popViewControllerAnimated(true)
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

extension RegisterVC : UITextFieldDelegate {
    
    
    func animateTextField(textField: UITextField, up: Bool, withOffset offset:CGFloat)
    {
        let movementDistance : Int = -Int(offset)
        let movementDuration : Double = 0.4
        let movement : Int = (up ? movementDistance : -movementDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        self.view.frame = CGRectOffset(self.view.frame, 0, CGFloat(movement))
        UIView.commitAnimations()
    }
    
    func textFieldDidBeginEditing(textField: UITextField)
    {
        self.animateTextField(textField, up: true, withOffset: textField.frame.origin.y / 2)
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        self.animateTextField(textField, up: false, withOffset: textField.frame.origin.y / 2)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    
    
}
