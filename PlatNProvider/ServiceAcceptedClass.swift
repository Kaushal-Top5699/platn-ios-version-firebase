//
//  ServiceAcceptedClass.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/27/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import Foundation

class ServiceAcceptedClass {
    
    var id:String
    var user_name:String
    var user_image:String
    var user_id:String
    var time:String
    var service_name:String
    var service:String
    var city:String
    var area:String
    var phone:String
    var address:String
    
    var email:String
    var estimatedate:String
    var estimatetime:String
    var image:String
    var name:String
    var paddress:String
    var phoneno:String
    var pid:String
    
    init(id:String, user_name:String, user_image:String, user_id:String, time:String, service_name:String, service:String, city:String, area:String, phone:String, address:String, email:String, estimatedate:String, estimatetime:String, image:String, name:String, paddress:String, phoneno:String, pid:String) {
        
        self.id = id
        self.user_name = user_name
        self.user_image = user_image
        self.user_id = user_id
        self.time = time
        self.service_name = service_name
        self.service = service
        self.city = city
        self.area = area
        self.phone = phone
        self.address = address
        
        self.email = email
        self.estimatedate = estimatedate
        self.estimatetime = estimatetime
        self.image = image
        self.name = name
        self.paddress = paddress
        self.phoneno = phoneno
        self.pid = pid
        
    }
    
    
}
