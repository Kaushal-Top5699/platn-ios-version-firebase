//
//  AcceptedTableViewCell.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit

class AcceptedTableViewCell: UITableViewCell {

    @IBOutlet var customerName: UILabel!
    
    @IBOutlet var givenDate: UILabel!
    
    @IBOutlet var givenTime: UILabel!
    
    @IBOutlet var serviceType: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func set(acceptedService: ServiceAcceptedClass) {
        
        customerName.text = acceptedService.user_name
        givenDate.text = acceptedService.estimatedate
        givenTime.text = acceptedService.estimatetime
        serviceType.text = acceptedService.service_name
        
    }
    
}
