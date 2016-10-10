//
//  EditInformacionVC.swift
//  Nao
//
//  Created by Luis on 5/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class EditInformacionVC: UIViewController {
    
    @IBOutlet weak var lblEdad: UILabel!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var txtUbicacion: UITextField!
    @IBOutlet weak var button: UIButton!
    
    var picker = GMPicker()
    var isYearPicked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "NAO"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(EditInformacionVC.popToViewController))

        button.addTarget(self, action: #selector(ListEmpresasVC.buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        lblEdad.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseGender)))
        lblEdad.userInteractionEnabled = true
        
        setupPickerView()
        // Do any additional setup after loading the view.
    }
    
    func chooseGender(){
        isYearPicked = false
        picker.setupGender()
        picker.show(inVC: self)
    }
    
    @objc func buttonClick(Sender: UIButton!) {
        
        if let string = txtEdad.text where string.isEmpty {
            showAlert("Ingrese su edad")
            return
        }
        
        if let string = lblEdad.text where string.isEmpty {
            showAlert("Ingrese su genero")
            return
        }
        
        if let string = txtUbicacion.text where string.isEmpty {
            showAlert("Ingrese su dirección")
            return
        }
        
        NSUserDefaults.standardUserDefaults().setObject(txtUbicacion.text!, forKey: "dir")
        NSUserDefaults.standardUserDefaults().setObject(txtEdad.text!, forKey: "edad")
        NSUserDefaults.standardUserDefaults().setObject(lblEdad.text == "Masculino" ? "1" : "0", forKey: "sexo")
        
        print("name \(NSUserDefaults.standardUserDefaults().objectForKey("name"))")
        print("mail \(NSUserDefaults.standardUserDefaults().objectForKey("mail"))")
        print("pass \(NSUserDefaults.standardUserDefaults().objectForKey("pass"))")
        print("urlPhoto \(NSUserDefaults.standardUserDefaults().objectForKey("urlPhoto"))")
        print("sub_cat \(NSUserDefaults.standardUserDefaults().objectForKey("sub_cat"))")
        print("companies_id \(NSUserDefaults.standardUserDefaults().objectForKey("companies_id"))")
        print("dir \(NSUserDefaults.standardUserDefaults().objectForKey("dir"))")
        print("edad \(NSUserDefaults.standardUserDefaults().objectForKey("edad"))")
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        self.presentViewController(controller, animated: true, completion: nil)
        
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension EditInformacionVC : UITextFieldDelegate {
    
    
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

extension EditInformacionVC: GMPickerDelegate {
    
    func gmPicker(gmPicker: GMPicker, didSelect string: String) {
        
        if !isYearPicked{lblEdad.text = string} else { lblEdad.text = string }
        
    }
    
    func gmPickerDidCancelSelection(gmPicker: GMPicker){
    }
    
    private func setupPickerView(){
        
        picker.delegate = self
        picker.config.animationDuration = 0.5
        
        picker.config.cancelButtonTitle = "Cancelar"
        picker.config.confirmButtonTitle = "Confirmar"
        
        picker.config.contentBackgroundColor = UIColor(red: 253/255.0, green: 253/255.0, blue: 253/255.0, alpha: 1)
        picker.config.headerBackgroundColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1)
        picker.config.confirmButtonColor = UIColor.blackColor()
        picker.config.cancelButtonColor = UIColor.blackColor()
        
    }
    
}
