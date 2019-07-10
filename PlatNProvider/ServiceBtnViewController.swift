//
//  ServiceBtnViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/29/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit

class ServiceBtnViewController: UIViewController {

    @IBOutlet var btnAvailableStyle: UIButton!
    
    @IBOutlet var btnAcceptedStyle: UIButton!
    
    @IBOutlet var btnRunningStyle: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnAvailableStyle.layer.cornerRadius = 8
        btnAvailableStyle.clipsToBounds = true
        
        btnAcceptedStyle.layer.cornerRadius = 8
        btnAcceptedStyle.clipsToBounds = true
        
        btnRunningStyle.layer.cornerRadius = 8
        btnRunningStyle.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
