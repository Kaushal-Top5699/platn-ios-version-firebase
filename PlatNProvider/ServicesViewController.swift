//
//  ServicesViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/31/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ServicesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var myTableView: UITableView!
    
    var services = [ServicesNoImage]()
    
    var theAcceptedServices = [ServiceAcceptedClass]()
    
    var databaseHandle:DatabaseHandle?
    
    var ref:DatabaseReference?
    
    var refresher:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refresher = UIRefreshControl()
        
        refresher.attributedTitle = NSAttributedString(string: "Loading...")
        
        refresher.addTarget(self, action: #selector(ServicesViewController.observeServices), for: UIControlEvents.valueChanged)
        
        myTableView.addSubview(refresher)
        
        ref = Database.database().reference()
        
        //myTableView = UITableView(frame: view.bounds, style: .plain)
        
        let cellNib = UINib(nibName: "ServiceTableViewCell", bundle: nil)
        
        myTableView.register(cellNib, forCellReuseIdentifier: "postCell")
        
        view.addSubview(myTableView)
        
        myTableView.separatorStyle = .none
        
        var layOutGuide: UILayoutGuide!
        
        if #available(iOS 11.0, *) {
            
            layOutGuide = view.safeAreaLayoutGuide //only for iOS 11
            
        } else {
            //Give the feedback
            layOutGuide = view.layoutMarginsGuide
            
        }
        
        //Constraints for tableView
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.tableFooterView = UIView()
        myTableView.reloadData()
        
        observeServices()
        
        navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
    }
    
    @objc func observeServices() {
        
        let userID = Auth.auth().currentUser?.uid
        
        var theCat = "none"
        
        databaseHandle = ref?.child("Providers").child(userID!).child("category").observe(.value, with: { (snapshot) in
            
            theCat = snapshot.value as! String
            
            print(theCat)
            
        })
        
        let postsRef = Database.database().reference().child("OpenService")
        
                //to get constant updating always use observeSingleEvent()
        postsRef.observeSingleEvent(of: .value, with: { snapshot in
            
            var tempServices = [ServicesNoImage]()
            
            for child2 in snapshot.children {
                
                    let childSnapshot = child2 as? DataSnapshot
                    let dict = childSnapshot?.value as? [String:Any]
                    let Address = dict!["Address"] as? String
                    let Phone = dict!["Phone"] as? String
                    let area = dict!["area"] as? String
                    let city = dict!["city"] as? String
                    let service = dict!["service"] as? String
                    let service_name = dict!["service_name"] as? String
                    let time = dict!["time"] as? String
                    let user_id = dict!["user_id"] as? String
                    let user_image = dict!["user_image"] as? String
                    let user_name = dict!["user_name"] as? String
                
                    if theCat.range(of: service_name!) != nil {
                        
                        let service2 = ServicesNoImage(id: (childSnapshot?.key)!, user_name: user_name!, user_image: user_image!, user_id: user_id!, time: time!, service_name: service_name!, service: service!, city: city!, area: area!, Phone: Phone!, Address: Address!)
                    
                        tempServices.append(service2)
                        
                    }
            }
            
            self.services = tempServices
            self.myTableView.reloadData()
            self.refresher.endRefreshing()
            
        })
        
    }
    
    func observeServicesTwo() {
        
        let userID = Auth.auth().currentUser?.uid
        
        var theCat = "none"
        
        databaseHandle = ref?.child("Providers").child(userID!).child("category").observe(.value, with: { (snapshot) in
            
            theCat = snapshot.value as! String
            
            print(theCat)
            
        })
        
        let postsRef = Database.database().reference().child("Providers_accepted_services")
            .child(userID!).child("accepted_services")
        
        postsRef.observe(.value, with: { snapshot in
            
            var tempServices = [ServicesNoImage]()
            
            for child2 in snapshot.children {
                
                let childSnapshot = child2 as? DataSnapshot
                let dict = childSnapshot?.value as? [String:Any]
                let Address = dict!["Address"] as? String
                let Phone = dict!["Phone"] as? String
                let area = dict!["area"] as? String
                let city = dict!["city"] as? String
                let service = dict!["service"] as? String
                let service_name = dict!["service_name"] as? String
                let time = dict!["time"] as? String
                let user_id = dict!["user_id"] as? String
                let user_image = dict!["user_image"] as? String
                let user_name = dict!["user_name"] as? String

                
                let service2 = ServicesNoImage(id: (childSnapshot?.key)!, user_name: user_name!, user_image: user_image!, user_id: user_id!, time: time!, service_name: service_name!, service: service!, city: city!, area: area!, Phone: Phone!, Address: Address!)

                tempServices.append(service2)
                
            }
            
            self.services = tempServices
            self.myTableView.reloadData()
            
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return services.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! ServiceTableViewCell
        
        cell.set(service: services[indexPath.row])
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = services[indexPath.row].id as String
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let DVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        DVC.myString = key
        
        databaseHandle = ref?.child("OpenService").child(key).child("user_id").observe(.value, with: { (snapshot) in
            
            let theUsernameID = snapshot.value as! String
            DVC.customeID = theUsernameID
            
            let alertController = UIAlertController(title: "Trial", message: key+" "+theUsernameID, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Close Alert", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        })
        
        self.navigationController?.pushViewController(DVC, animated: true)
        
    }
}
