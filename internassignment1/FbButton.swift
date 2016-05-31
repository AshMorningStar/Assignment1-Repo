//
//  FbButton.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 5/5/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import UIKit

class FbButton: UIButton {

    override func awakeFromNib() { //called when the User interface is loaded from the storyboard.
        layer.cornerRadius = 2.0
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.5 //How fat do you want to shadow to cover
        layer.shadowOffset = CGSizeMake(0.0, 2.0) //Offsettign on the x axis.
        
    }
}
