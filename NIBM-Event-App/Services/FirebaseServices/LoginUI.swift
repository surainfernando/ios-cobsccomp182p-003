//
//  LoginUI.swift
//  NIBM-Event-App
//
//  Created by user161121 on 2/25/20.
//  Copyright © 2020 surainfdo. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class LoginUI{
    
    func login(email:String,password:String)->Bool{
        var check=false
        Auth.auth().signIn(withEmail: email, password: password) {
            (user, error) in
            
            let user1 = Auth.auth().currentUser
            print("block1/1-----------------------------------")
            if let user1=user1 {
                print("block2/1-----------------------------------")
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                //                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                //                        changeRequest?.displayName = "Surain FFF"
                //                        changeRequest?.commitChanges { (error) in
                //                            // ...
                //                        }
                //
                print(user1.uid)
                guard let hh=user1.displayName else{
                    return
                }
                print("User name is -----------------------------------00")
                print(hh)
                
            }
            
            if error==nil{
                check=true// check==0 indicates no error
                
            }
            else{
               print("error login----------------------------------------")
            }
        }
        return check
    }
    
    func checkIfEmailExists(email:String)->Bool
    {
        var check=false
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue.main.async {
            Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
                var check=true
                
                if ((error) != nil) {
                    
                    return
                    // Handle error case.
                }
                
                guard let val=signInMethods else
                { print("-false empty---------------------")
                    return
                }
                check=true
                print("loc 68----ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
                
                
            }
        }
        
        group.notify(queue: .main) {
            print("Simulation finished")
        
        }
        return check
    }
    
    
//    func checkIfEmailExists(Email:String)->Bool{
//        print("loc 3-----------------------")
//        var check=false
//    checkIfEmailExistsCompletion(email: Email)
//    {Email in print("loc4----------------------------")
//        check=Email
//        }
//       return check
//    }
    
    func checkEmail2(email:String)-> Bool{
        var check=false;
        DispatchQueue.global(qos: .utility).async {
            DispatchQueue.main.async {
                Auth.auth().fetchSignInMethods(forEmail: email) { signInMethods, error in
                    
                    
                    if ((error) != nil) {
                        // Handle error case.
                    }
                    
                    guard let val=signInMethods else
                    { print("-false---------------------")
                        return
                    }
                    check=true
                    print("loc 6----ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd")
                   
                    
                }
                
         
            }
            
        }
        return check
        
    }
    
}
