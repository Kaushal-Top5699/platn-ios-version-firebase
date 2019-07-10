//
//  UserService.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import Foundation
import Firebase

class UserService {
    
    static var currentUserProfile:UserProfile?
    
    static func observeUserProfile(_ uid:String, completion:@escaping ((_ userProfile:UserProfile?)->())) {
        
        let userRef = Database.database().reference().child("Providers/\(uid)")
        
        userRef.observe(.value, with: { snapshot in
            
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["username"] as? String,
                let image = dict["image"] as? String,
                let url = URL(string: image),
                let providerEmailAdd = dict["useremailaddress"] as? String,
                let city = dict["city"] as? String,
                let category = dict["category"] as? String,
                let area = dict["area"] as? String {
                
                userProfile = UserProfile(uid: snapshot.key, username: username, useremailaddress: providerEmailAdd, image: url, city: city, category: category, area: area)
                
            }
            
            completion(userProfile)
            
        })
        
    }
    
}
