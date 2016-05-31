//
//  ViewController.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 27/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MapKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var inSearchMode = false
    var refreshControl: UIRefreshControl!
    
    
    var parkingSpaces = [ParkingLot]()
 
    var dynamicParkingSpaces = [DynamicParking]()
    
    var combinedDataArray = [CombinedData]()
    var filteredCombinedDataArray = [CombinedData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
       
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    
        searchBar.returnKeyType = UIReturnKeyType.Done
        retrieveStaticParkingInfo() //retreives static info,then dynamic info,then syncs them into a combinedDataArray
        
        
        
        
        
        
        
        
    }
    
    func refresh(){
        combinedDataArray = [CombinedData]()
        parkingSpaces = [ParkingLot]()
        filteredCombinedDataArray = [CombinedData]()
        dynamicParkingSpaces = [DynamicParking]()
        
        retrieveStaticParkingInfo()
        self.tableView.reloadData()
        
        refreshControl.endRefreshing()
    }
    
  
    
    func syncData(){
        for var x = 0;x < parkingSpaces.count ;x += 1 {
            
            for var y = 0;y<dynamicParkingSpaces.count; y += 1 {
            if parkingSpaces[x].id == dynamicParkingSpaces[y].id{
                let combinedData = CombinedData(id: parkingSpaces[x].id, zone: parkingSpaces[x].zone, name: parkingSpaces[x].name, capacity: parkingSpaces[x].capacity, rates: parkingSpaces[x].rates, publicHolidayRates: parkingSpaces[x].publicHolidayRates, dataProvider: parkingSpaces[x].dataProvider, vacancy: dynamicParkingSpaces[x].vacancy, status: dynamicParkingSpaces[x].status,address:parkingSpaces[x].address,longitude: parkingSpaces[x].longitude,latitude: parkingSpaces[x].latitude)
                
                combinedDataArray.append(combinedData)
            
            }
        }
        }
        
       self.tableView.reloadData()
        
    }
    func retrieveStaticParkingInfo(){
        
        let parkingLotInfoURL = "http://api.mapsynq.com/api/1.0/feeds/pds.json"
        
        Alamofire.request(.GET, parkingLotInfoURL).responseJSON { (reponse) in //web request to get jso n data
            if let response = reponse.data{
                
                let json = JSON(data:response) //using swiftyjson,converts the data from the web to a JSON Object.
                
                let data = json["data"].arrayValue //retrieves the "data" from json
                
                for items in data{
                    let id = items["id"].intValue
                    let zone = items["zone"].stringValue
                    let name = items["name"].stringValue
                    let capacity = items["capacity"].intValue
                    let rates = items["rates"].stringValue
                    let publicHoildayRates = items["rates"].stringValue
                    let dataProvider = items["data_provider"].stringValue
                    let address = items["address"].stringValue
                    let longitude = items["lon"].stringValue
                    let latitude = items["lat"].stringValue
                    
                   // print(longitude)
                    
                    let parkingLot = ParkingLot(id: id, zone: zone, name: name, capacity: capacity, rates: rates, publicHolidayRates: publicHoildayRates, dataProvider: dataProvider,address: address, longitude: longitude,latitude: latitude)
                    
                    self.parkingSpaces.append(parkingLot)
                                    }
                
               
                self.retrieveDynamicParkingInfo()
                //self.tableView.reloadData()
                
            }
            
            
        }
    }
    
    
    func retrieveDynamicParkingInfo(){
        let dynamicParkingInfoURL = "http://api.mapsynq.com/api/1.0/feeds/pdd.json"
        Alamofire.request(.GET, dynamicParkingInfoURL).responseJSON { (reponse) in
            if let response = reponse.data{
                
                let json = JSON(data:response)
                
                let dynamicData = json["data"].arrayValue
                
                for items in dynamicData {
                    let id = items["id"].intValue
                    let vacancy = items["vacancy"].stringValue
                    let status = items["status"].intValue
                    
                    let dynamicParking = DynamicParking(id: id, vacancy: vacancy, status: status)
                    
                    self.dynamicParkingSpaces.append(dynamicParking)
                    
                    
                }
                
                self.syncData()
                
                
            }
           
        
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        if searchBar.text == nil || searchBar.text == ""{
            return combinedDataArray.count
        }else{
            return filteredCombinedDataArray.count
        }

    }
    
       func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
               if let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as? CustomTableViewCell{
        
                     let combinedData:CombinedData!
            
            if inSearchMode{
                combinedData = self.filteredCombinedDataArray[indexPath.row]
                
            }else{
                combinedData = self.combinedDataArray[indexPath.row]
                
                
            }
            
            cell.configureCell(combinedData)
            return cell
        }else{
            return UITableViewCell()
        }
        
    
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var combinedData:CombinedData!
        
        if inSearchMode{
      
            combinedData = filteredCombinedDataArray[indexPath.row]
            
        }else{
       
            combinedData = combinedDataArray[indexPath.row]
        }
        
        performSegueWithIdentifier("LotDetailsVC", sender: combinedData)
        
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true) //by ending the editing,the keyboard will then hide
            tableView.reloadData()
            
        }else{
            inSearchMode = true
            
            let lowerCase = searchBar.text!.lowercaseString
            
            filteredCombinedDataArray = combinedDataArray.filter({$0.name.lowercaseString.rangeOfString(lowerCase) != nil})
           
            tableView.reloadData()

            
        }
        
      //  tableView.reloadData()

        
    }
    

    
    
      
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "LotDetailsVC"{
            if let detailsVC = segue.destinationViewController as? LotDetailsVC{
                if let combinedData = sender as? CombinedData{
                    detailsVC.combinedData = combinedData
                }
            }
        }
    }

    
   


}

