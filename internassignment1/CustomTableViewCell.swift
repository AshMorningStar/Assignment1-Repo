//
//  CustomTableViewCell.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 29/4/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var zoneLbl: UILabel!
    @IBOutlet weak var lotsVacancyLbl: UILabel!
    
    var combinedData: CombinedData!
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       // layer.cornerRadius = 5.0
    }
    
    func configureCell(combinedData:CombinedData){
        self.combinedData = combinedData
        
        self.nameLbl.text = combinedData.name
        self.zoneLbl.text = combinedData.zone
        self.lotsVacancyLbl.text = combinedData.vacancy
        
        
        
        
        
        
        
    }

}
