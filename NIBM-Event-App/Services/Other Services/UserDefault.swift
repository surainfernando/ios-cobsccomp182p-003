//
//  UserDefault.swift
//  NIBM-Event-App
//
//  Created by user161121 on 3/4/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import Foundation
class UserDefault
{
  
    func setDefaults(fname:String,lname:String,contactNumber:String,fbURL:String,image:String,email:String)
    {
      UserDefaults.standard.set(fname, forKey: "FirstName")
        UserDefaults.standard.set(lname, forKey: "LastName")
        UserDefaults.standard.set(contactNumber, forKey: "ContactNumber")
            UserDefaults.standard.set(fbURL, forKey: "FBUrl")
            UserDefaults.standard.set(image, forKey: "ImageString")
            UserDefaults.standard.set(email,forKey: "Email")


    }
    func getFirstName()->String
    {
        let name = UserDefaults.standard.string(forKey: "FirstName") ?? "Unknown user"
        return name
    }
    func getLastName()->String
    {
        let name = UserDefaults.standard.string(forKey: "LastName") ?? "Unknown user"
        return name
    }
    func getFBURL()->String
    {
        let name = UserDefaults.standard.string(forKey: "FBUrl") ?? "Unknown user"
        return name
    }
    func getContactNumber()->String
    {
        let name = UserDefaults.standard.string(forKey: "ContactNumber") ?? "Unknown user"
        return name
    }
    func getImageString()->String
    {
        let name = UserDefaults.standard.string(forKey: "ImageString") ?? "Unknown user"
        return name
    }
    func getEmail()->String
    {
        let name = UserDefaults.standard.string(forKey: "Email") ?? "Unknown user"
        return name
    }
    
    
    
    
    
    
    
   
    
}
