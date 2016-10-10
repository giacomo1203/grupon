//
//  ListGustosVC.swift
//  Nao
//
//  Created by Luis on 3/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class ListGustosVC: UIViewController {
    
    var subCategories = [Subcategory]()
    var isShowing = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = false
        self.tableView.reloadData()
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController!.navigationBar.translucent = true
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(ListGustosVC.popToViewController))
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        self.navigationItem.title = "NAO"

        button.addTarget(self, action: #selector(ListCatVC.buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func popToViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @objc func buttonClick(Sender: UIButton!) {
        
        for item in subCategories {
            if item.alredyInvited {
                print(item)
            }else {
                print("no exsite")
            }
        }
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ListEmpresasVC") as! ListEmpresasVC
        self.navigationController?.pushViewController(vc, animated: true)

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


extension ListGustosVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let comment = subCategories[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let nameCategory = cell.viewWithTag(100) as? UILabel
        let iconCategory = cell.viewWithTag(101) as? UIImageView
        let iconCheck = cell.viewWithTag(102) as? UIImageView
        
        cell.selectionStyle = .None
        
        nameCategory!.text = comment.name
        
        iconCategory!.sd_setImageWithURL(NSURL(string: ("http://ipfcom.org/grupon/" + comment.icon!)), placeholderImage: UIImage(named: "userPlaceholder"))
        /*
        if comment.alredyInvited {
            cell.accessoryType = .Checkmark
        }else {
            cell.accessoryType = .None
        }*/
        
        if comment.alredyInvited {
            iconCheck?.image = UIImage(named: "check")
        }else {
            iconCheck?.image = UIImage(named: "uncheck")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.subCategories[indexPath.row].alredyInvited = self.subCategories[indexPath.row].alredyInvited ? false : true
        self.tableView.reloadData()
    }
    
}
