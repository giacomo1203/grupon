//
//  HomeVC.swift
//  Nao
//
//  Created by Procesos on 19/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    var userInformation = [String : AnyObject]()
    
    @IBOutlet weak var button: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(HomeVC.popToViewController))
        
        button.addTarget(self, action: #selector(RegisterVC.register(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func register(Sender: UIButton!) {
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func popToViewController() {
        self.navigationController?.popViewControllerAnimated(true)
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
