//
//  LotDetailsVC.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 29/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit
import MapKit

class LotDetailsVC: UIViewController,MKMapViewDelegate {
    
    @IBOutlet weak var titleName: UILabel!
    //@IBOutlet weak var rates: UILabel!
//    @IBOutlet weak var publicHolidayRates: UILabel!
    @IBOutlet weak var _zone:UILabel!
  //  @IBOutlet weak var capacity:UILabel!
    @IBOutlet weak var address:UILabel!
    @IBOutlet weak var mapView: MKMapView!

    let locationManager = CLLocationManager()
    let regionRadius: CLLocationDistance = 1000
  //  let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    var parkingLocation : CLLocation!
    
    
    var combinedData: CombinedData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
       titleName.text = combinedData.name
       // rates.text = combinedData.rates
     //   publicHolidayRates.text = combinedData.publicHolidayRates
        _zone.text = combinedData.zone
        if let address = combinedData.address as? String{
         self.address.text = address
        }
        
       // capacity.text = "\(combinedData.capacity)"
        print(combinedData.latitude)
        let longitude = Double(combinedData.longitude)!
        let latitude = Double(combinedData.latitude)!
        
        parkingLocation = CLLocation(latitude: latitude, longitude: longitude)
     
        centerMapOnLocation(parkingLocation) //Displays the location of that parking lot on the map.
        createAnnotation(parkingLocation)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        locationAuthorization() //Called whenver the screen appears.
        //wcenterMapOnLocation(<#T##location: CLLocation##CLLocation#>)
        
    }
    
  
   
    @IBAction func backBtnPressed(sender: AnyObject) {
       dismissViewControllerAnimated(true, completion: nil)
    }
 
    func createAnnotation(location:CLLocation){
        let parkingLotAnnotation = ParkingLotAnnotation(coordinate: location.coordinate)
        mapView.addAnnotation(parkingLotAnnotation)
    }
    
    func getPlaceMarkForLocation(address:String){
        CLGeocoder().geocodeAddressString(address) { (placeMark:[CLPlacemark]?, error :NSError?) in
            if let marks = placeMark {
                if let loc = marks[0].location{
                    self.createAnnotation(loc)
                }
                
            }
        }
    }
    
    
    func locationAuthorization(){
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse{
            mapView.showsUserLocation = true
           
        }
        else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
  /*  func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) { //is called whenever the location of the user is updated.
        if let location = userLocation.location{
            centerMapOnLocation(location)
        }
    }*/
    
    func centerMapOnLocation(location:CLLocation){
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }

}
