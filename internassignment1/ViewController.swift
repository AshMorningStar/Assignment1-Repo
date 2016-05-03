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


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet var tableView:UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var inSearchMode = false
    
    
    //var namesStorage: [String] = []
    var parkingSpaces = [ParkingLot]()
    var filteredParkingSpaces = [ParkingLot]()
    
    var dynamicParkingSpaces = [DynamicParking]()
    
    var combinedDataArray = [CombinedData]()
    var filteredCombinedDataArray = [CombinedData]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
    
        retrieveStaticParkingInfo()
        
        
        
        
        
        
    }
    
  
    
    func syncData(){
        for var x = 0;x < parkingSpaces.count ;x++ {
            
            for var y = 0;y<dynamicParkingSpaces.count; y++ {
            if parkingSpaces[x].id == dynamicParkingSpaces[y].id{
               let combinedData = CombinedData(id: parkingSpaces[x].id, zone: parkingSpaces[x].zone, name: parkingSpaces[x].name, capacity: parkingSpaces[x].capacity, rates: parkingSpaces[x].rates, publicHolidayRates: parkingSpaces[x].publicHolidayRates, dataProvider: parkingSpaces[x].dataProvider, vacancy: dynamicParkingSpaces[x].vacancy, status: dynamicParkingSpaces[x].status)
                
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
                
                /*for names in data{  //for each "name" form the data arrray,store it in a String array,called namesStorage
                 let name = names["name"].stringValue
                 
                 // print(name)
                 self.namesStorage.append(name)
                 
                 }*/
                
                for items in data{
                    let id = items["id"].intValue
                    let zone = items["zone"].stringValue
                    let name = items["name"].stringValue
                    let capacity = items["capacity"].intValue
                    let rates = items["rates"].stringValue
                    let publicHoildayRates = items["rates"].stringValue
                    let dataProvider = items["data_provider"].stringValue
                    
                    let parkingLot = ParkingLot(id: id, zone: zone, name: name, capacity: capacity, rates: rates, publicHolidayRates: publicHoildayRates, dataProvider: dataProvider)
                    
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
                //self.tableView.reloadData()

                
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
       
        print("it did go here")
        if let cell = tableView.dequeueReusableCellWithIdentifier("detailsCell", forIndexPath: indexPath) as? CustomTableViewCell{
        
            //let parking: ParkingLot!
           // let dynamic: DynamicParking!
            
            let combinedData:CombinedData!
            
            if inSearchMode{
              //  parking = self.filteredParkingSpaces[indexPath.row]
                //dynamic = self.dynamicParkingSpaces[indexPath.row]
                combinedData = self.filteredCombinedDataArray[indexPath.row]
                
            }else{
               // parking = self.parkingSpaces[indexPath.row]
               // dynamic = self.dynamicParkingSpaces[indexPath.row]
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
        // let selectedParkingName = namesStorage[indexPath.row]
        //   print("User has selected \(selectedParkingName)")
        
        //var parkingLot:ParkingLot!
        var combinedData:CombinedData!
        
        if inSearchMode{
           // parkingLot = filteredParkingSpaces[indexPath.row]
            combinedData = filteredCombinedDataArray[indexPath.row]
            
        }else{
          //  parkingLot = parkingSpaces[indexPath.row]
            combinedData = combinedDataArray[indexPath.row]
        }
        
        performSegueWithIdentifier("LotDetailsVC", sender: combinedData)
        
        
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            view.endEditing(true) //by ending the editing,the keyboard will then hide
            
            
        }else{
            inSearchMode = true
            
            let lowerCase = searchBar.text!.lowercaseString
            
            //filteredParkingSpaces = parkingSpaces.filter({$0.name.rangeOfString(lowerCase) != nil})
            filteredCombinedDataArray = combinedDataArray.filter({$0.name.rangeOfString(lowerCase) != nil})
            
        }
        
        tableView.reloadData()

        
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

