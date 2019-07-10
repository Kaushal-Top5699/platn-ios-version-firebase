//
//  AcceptedViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit
import Firebase

class AcceptedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var AcceptedTableView: UITableView!
    
    var theAcceptedServices = [ServiceAcceptedClass]()
    
    var databaseHandle:DatabaseHandle?
    
    var ref:DatabaseReference?
    
    var refresher:UIRefreshControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        let cellNib = UINib(nibName: "AcceptedTableViewCell", bundle: nil)
        
        AcceptedTableView.register(cellNib, forCellReuseIdentifier: "postCells")
        
        view.addSubview(AcceptedTableView)
        
        AcceptedTableView.separatorStyle = .none
        
        var layOutGuide: UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            
            layOutGuide = view.safeAreaLayoutGuide //only for iOS 11
            
        } else {
            //Give the feedback
            layOutGuide = view.layoutMarginsGuide
            
        }
        
        //Constraints for tableView
        AcceptedTableView.delegate = self
        AcceptedTableView.dataSource = self
        AcceptedTableView.tableFooterView = UIView()
        AcceptedTableView.reloadData()
      
        observeServices()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func observeServices() {
        
        let userID = Auth.auth().currentUser?.uid
        
        let postsRef = Database.database().reference().child("Providers_accepted_services")
            .child(userID!).child("accepted_services")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempServices = [ServiceAcceptedClass]()
            
            for child in snapshot.children {
                
                let childSnapshot = child as? DataSnapshot
                let dict = childSnapshot?.value as? [String:Any]
                let user_name = dict!["user_name"] as? String
                let user_image = dict!["user_image"] as? String
                let estimatedate = dict!["estimatedate"] as? String
                let estimatetime = dict!["estimatetime"] as? String
                let service_name = dict!["service_name"] as? String
                let time = dict!["time"] as? String
                let service = dict!["service"] as? String
                let user_id = dict!["user_id"] as? String
                let email = dict!["email"] as? String
                let image = dict!["image"] as? String
                let paddress = dict!["paddress"] as? String
                let phoneno = dict!["phoneno"] as? String
                let name = dict!["name"] as? String
                let pid = dict!["pid"] as? String
                let city = dict!["city"] as? String
                let area = dict!["area"] as? String
                let phone = dict!["phone"] as? String
                let address = dict!["address"] as? String
                //let pverificationcode = dict!["pverificationcode"] as? String
                
                
                let myServices = ServiceAcceptedClass(id: (childSnapshot!.key), user_name: user_name!, user_image: user_image!, user_id: user_id!, time: time!, service_name: service_name!, service: service!, city: city!, area: area!, phone: phone!, address: address!, email: email!, estimatedate: estimatedate!, estimatetime: estimatetime!, image: image!, name: name!, paddress: paddress!, phoneno: phoneno!, pid: pid!)
             
                tempServices.append(myServices)
                
            }
            
            self.theAcceptedServices = tempServices
            self.AcceptedTableView.reloadData()
            
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return theAcceptedServices.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCells", for: indexPath) as! AcceptedTableViewCell
        
        cell.set(acceptedService: theAcceptedServices[indexPath.row])

        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
