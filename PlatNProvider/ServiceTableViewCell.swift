//
//  ServiceTableViewCell.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit

class ServiceTableViewCell: UITableViewCell {
    
    @IBOutlet var serviceType: UILabel!
    
    @IBOutlet var newTimeLabel: UILabel!
    
    @IBOutlet var userAddress: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(service: ServicesNoImage) {
        
        userAddress.text = service.Address
        newTimeLabel.text = service.time
        serviceType.text = service.service_name
        
    }
    
}
