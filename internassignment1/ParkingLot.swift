//
//  ParkingLot.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 27/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import Foundation


struct ParkingLot{
    private var _id: Int!
    private var _zone:String!
    private var _name: String!
    private var _capacity: Int!
    private var _rates: String!
    private var _publicHolidayRates: String!
    private var _dataProvider: String!
    private var _address:String!
    private var _longitude: String!
    private var _latitude:String!
    
    
    var id:Int{
        return _id
    }
    
    var zone:String{
        return _zone
    }
    
    var name:String{
        
        return _name
    }
    
    var capacity:Int{
        return _capacity
    }
    
    var rates:String{
        return _rates
    }
    
    var publicHolidayRates:String{
        return _publicHolidayRates
    }
    
    var dataProvider:String{
        return _dataProvider
    }
    
    var address:String{
        return _address
    }
    
    var longitude:String{
        return _longitude
    }
 
    var latitude:String{
        return _latitude
    }
    
    
    
    init(id: Int,zone:String,name:String,capacity:Int,rates:String,publicHolidayRates:String,dataProvider:String,address:String,longitude:String,latitude:String){
        _id = id
        _zone = zone
        _name = name
        _capacity = capacity
        _rates = rates
        _publicHolidayRates = publicHolidayRates
        _dataProvider = dataProvider
        _address = address
        _longitude = longitude
        _latitude = latitude
        
    }
    
    
    
    
    
    
    
}