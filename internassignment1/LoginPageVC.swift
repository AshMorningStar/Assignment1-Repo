//
//  LoginPageVC.swift
//  internassignment1
//
//  Created by Mohamad Asyraaf on 5/5/16.
//  Copyright © 2016 Mohamad Asyraaf bin Abdul Rahman. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase
import FBSDKCoreKit


class LoginPageVC:UIViewController{
    
    
    
    let ref = Firebase(url: "https://ash-parking-app.firebaseio.com")
    let facebookLogin = FBSDKLoginManager()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil{ //if the KEY_UID ("uid") exists,it means that the user has already logged in .
            self.performSegueWithIdentifier("loggedIn", sender: nil)
        }
    }
    
    
    
    
    @IBAction func fbLoginBtnPressed(sender:UIButton!){
        facebookLogin.logInWithReadPermissions(["email"]) { (fbResult:FBSDKLoginManagerLoginResult!, facebookError:NSError!) in
            
            if facebookError != nil{
                print("Facebook Login Failed.Error \(facebookError)")
            }else{
                let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
                
                self.ref.authWithOAuthProvider("facebook", token: accessToken, withCompletionBlock: { (error:NSError!, authData:FAuthData!) in
                    
                    
                    if error != nil{
                         print("Login failed. \(error)")
                    }else{
                         print("Logged In! \(authData)")
                        
                        NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")  //What does this do?
                        
                        self.performSegueWithIdentifier("loggedIn", sender: nil)
                        
                        
                        
                    }
                })
            }
            
            
            
            
            
            
        }
        
        }
    
    
    
    
    
    
}