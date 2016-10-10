
//
//  ListEmpresasVC.swift
//  Nao
//
//  Created by Luis on 3/10/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit

class ListEmpresasVC: UIViewController {
    
    var currentCompanyInTable = CompanyManager.sharedInstance.eventArray
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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: .Plain, target: self, action: #selector(ListEmpresasVC.popToViewController))
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = .None
        self.navigationItem.title = "NAO"

        button.addTarget(self, action: #selector(ListEmpresasVC.buttonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonClick(Sender: UIButton!) {
        
        var arreglo = [Int]()
        
        
        for item in currentCompanyInTable {
            if item.alredyInvited {
                arreglo.append(item.Id)
            }
        }
        
        NSUserDefaults.standardUserDefaults().setObject(String(arreglo), forKey: "companies_id")
        
        let vc = self.storyboard!.instantiateViewControllerWithIdentifier("EditInformacionVC") as! EditInformacionVC
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListEmpresasVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCompanyInTable.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let company = currentCompanyInTable[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let nameCategory = cell.viewWithTag(100) as? UILabel
        let iconCategory = cell.viewWithTag(101) as? UIImageView
        
        cell.selectionStyle = .None
        
        nameCategory!.text = company.name
        
        iconCategory!.sd_setImageWithURL(NSURL(string: ("http://ipfcom.org/grupon/" + company.logo!)), placeholderImage: UIImage(named: "userPlaceholder"))
        
        if company.alredyInvited {
            cell.accessoryType = .Checkmark
        }else {
            cell.accessoryType = .None
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.currentCompanyInTable[indexPath.row].alredyInvited = self.currentCompanyInTable[indexPath.row].alredyInvited ? false : true
        self.tableView.reloadData()
    }
    
}
