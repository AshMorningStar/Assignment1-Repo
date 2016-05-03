//
//  LotDetailsVC.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 29/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit

class LotDetailsVC: UIViewController {
    
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var nameDetail:UILabel!

    
    
    
    var combinedData: CombinedData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       titleName.text = combinedData.name
     
        
        
    }

}
