//
//  UserProfile.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import Foundation

class UserProfile {
    
    var uid:String
    var username:String
    var useremailaddress:String
    var city:String
    var category:String
    var area:String
    var image:URL
    
    init(uid:String, username:String, useremailaddress:String, image:URL,
         city:String, category:String, area:String) {
        
        self.uid = uid
        self.username = username
        self.image = image
        self.useremailaddress = useremailaddress
        self.city = city
        self.category = category
        self.area = area
    }
    
}
