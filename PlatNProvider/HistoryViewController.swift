//
//  HistoryViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/17/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var databaseHandle:DatabaseHandle?
    
    var ref:DatabaseReference?
    
    @IBOutlet var horizontalScrolling: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        
        let deadline = DispatchTime.now() + .seconds(seconds)
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = horizontalScrolling.dequeueReusableCell(withReuseIdentifier: "theCell", for: indexPath)
        as? TestCollectionViewCell
        
        if indexPath.row == 0 {
            
            cell?.btnTest.setTitle("Events", for: .normal)
            
        } else if indexPath.row == 1 {
            
            cell?.btnTest.setTitle("Sales", for: .normal)
            
        } else if indexPath.row == 2 {
            
            cell?.btnTest.setTitle("Rooms", for: .normal)
            
        }
        
        return cell!
        
    }
    
    
}
