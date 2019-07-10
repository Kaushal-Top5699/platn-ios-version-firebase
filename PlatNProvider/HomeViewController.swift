//
//  HomeViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet var btnServiceStyle: UIButton!
    
    @IBOutlet var btnHistoryStyle: UIButton!
    
    @IBOutlet var btnLogOutStyle: UIBarButtonItem!
    
    @IBOutlet var btnViewProfileStyle: UIButton!
    
    @IBOutlet var importantNote: UILabel!
    
    var ref: DatabaseReference?
    
    var databaseHandle:DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnLogOutStyle.tintColor = .white
        
        btnServiceStyle.layer.cornerRadius = 8
        btnServiceStyle.clipsToBounds = true
        
        btnHistoryStyle.layer.cornerRadius = 8
        btnHistoryStyle.clipsToBounds = true
        
        btnViewProfileStyle.layer.cornerRadius = 5
        btnViewProfileStyle.clipsToBounds = true
        
        let userID = Auth.auth().currentUser?.uid
        
        print(userID)
        
        ref = Database.database().reference()
        
        databaseHandle = ref?.child("Notice064").child("imp_note_PVD").observe(.value, with: { (snapshot) in
            
            let theMsg = snapshot.value
            
            self.importantNote.text = theMsg as? String
            
        })
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnLogOut(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
    }
}
