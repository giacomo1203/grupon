//
//  ListCatVC.swift
//  Nao
//
//  Created by Procesos on 28/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class ListCatVC: UIViewController {
    
    var categories = [Category]()
    var subCategories = [Subcategory]()
    
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(ListCatVC.popToViewController))
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        self.navigationItem.title = "NAO"
        
        self.view.backgroundColor = UIColor.backgroundMenu()
        UITableViewCell .appearance().tintColor = UIColor.orangeColor()
        //tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        self.tableView.allowsMultipleSelection = true
        
        EventServices.getAllEvents { (categories, error) in
            
            NSOperationQueue.mainQueue().addOperationWithBlock {
                
                self.categories = categories!
                self.tableView.reloadData()
            }
        }
        
        button.addTarget(self, action: #selector(ListCatVC.buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func popToViewController() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonClick(Sender: UIButton!) {
        
        var arreglo = [Int]()
        
        subCategories.removeAll()
        
        for item in categories {
            if item.alredyInvited {
                for item in item.subcategorys {
                    subCategories.append(item)
                    arreglo.append(item.subcategoryID!)
                }
            }
        }
        
        NSUserDefaults.standardUserDefaults().setObject(String(arreglo), forKey: "sub_cat")
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("ListGustosVC") as! ListGustosVC
        vc.subCategories = subCategories
        self.navigationController?.pushViewController(vc, animated: true)
        
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

extension ListCatVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let comment = categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let nameCategory = cell.viewWithTag(100) as? UILabel
        let iconCategory = cell.viewWithTag(101) as? UIImageView
        let iconCheck = cell.viewWithTag(102) as? UIImageView
        
        cell.selectionStyle = .None
        
        nameCategory!.text = comment.name
        
        iconCategory!.sd_setImageWithURL(NSURL(string: ("http://ipfcom.org/grupon/" + comment.icono)), placeholderImage: UIImage(named: "userPlaceholder"))
        
        if comment.alredyInvited {
            iconCheck?.image = UIImage(named: "check")
        }else {
            iconCheck?.image = UIImage(named: "uncheck")
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.categories[indexPath.row].alredyInvited = self.categories[indexPath.row].alredyInvited ? false : true
        self.tableView.reloadData()
    }
    
}

