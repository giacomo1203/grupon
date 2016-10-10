//
//  MapOfertasVC.swift
//  Nao
//
//  Created by Procesos on 27/09/16.
//  Copyright © 2016 peru. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapOfertasVC: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView!
    var locationPin = GMSMarker()
    var currentEventsInTable = CompanyManager.sharedInstance.eventArray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "OFERTAS CERCAS"
        
        //mapView.delegate = self
        mapView.settings.rotateGestures = false
        mapView.settings.tiltGestures = false
        mapView.myLocationEnabled = false
        
        mapView.camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: -12.074987, longitude:-77.053890), zoom: 15, bearing: 0, viewingAngle: 0)
        
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        }
        

        
        self.createPinsInMap(self.currentEventsInTable)
        // Do any additional setup after loading the view.
    }
    
    func createPinsInMap(eventsArray:[Company]) {
        
        mapView.clear()
        
        for item in eventsArray {
            let marker = CompanyMarker(company: item)
            marker.map = mapView
        }
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
