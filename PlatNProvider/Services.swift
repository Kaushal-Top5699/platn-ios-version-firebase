//
//  Services.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import Foundation

class Services {
    
    var id:String
    var user_name:String
    var user_image:URL
    var user_id:String
    var time:String
    var service_name:String
    var service:String
    var city:String
    var area:String
    var Phone:String
    var Address:String
    
    init(id:String, user_name:String, user_image:URL, user_id:String, time:String, service_name:String, service:String, city:String, area:String, Phone:String, Address:String) {
        
        self.id = id
        self.user_name = user_name
        self.user_image = user_image
        self.user_id = user_id
        self.time = time
        self.service_name = service_name
        self.service = service
        self.city = city
        self.area = area
        self.Phone = Phone
        self.Address = Address
        
    }
    
}
