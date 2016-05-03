//
//  DynamicParking.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 29/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import Foundation


class DynamicParking{
   private var _id: Int!
   private var _vacancy:String!
   private var _status:Int!
    
    var id:Int{
        return _id
    }
    
    var vacancy:String{
        return _vacancy
    }
    
    var status:Int{
        return _status
    }
    
    init(id:Int,vacancy:String,status:Int){
        _id = id
        _vacancy = vacancy
        _status = status
        
    }
    
    
    
    
}