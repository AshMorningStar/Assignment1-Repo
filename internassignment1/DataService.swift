//
//  DataService.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 5/5/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import Foundation
import Firebase

class DataService{
    static let ds = DataService()
    
    
    private var _REF_BASE = Firebase(url: "https://ash-parking-app.firebaseio.com")
    
    
    var REF_BASE:Firebase {
        
        return _REF_BASE
        
    }
    
    
    
    
    
}