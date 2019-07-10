//
//  DetailsViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 8/1/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit
import Firebase

class DetailsViewController: UIViewController {

    var myString = String()
    
    var customeID = String()
    
    var activityindicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBOutlet var userProfileImage: UIImageView!
    
    @IBOutlet var customerName: UILabel!
    
    @IBOutlet var customerPhone: UILabel!
    
    @IBOutlet var customerAddress: UITextView!
    
    @IBOutlet var customerProb: UITextView!
    
    @IBOutlet var selectDate: UITextField!
    
    @IBOutlet var selectTime: UITextField!
    
    @IBOutlet var btnAccept: UIButton!
    
    @IBOutlet var problemImageOne: UIImageView!
    
    @IBOutlet var problemImageTwo: UIImageView!
    
    var databaseHandle:DatabaseHandle?
    
    var ref:DatabaseReference?
    
    var datePicker:UIDatePicker?
    
    var timePicker:UIDatePicker?
    
    //for storing info for service_status (User)
    var theUserID = "none"
    var thePhonePVD = "none"
    var theAddPVD = "none"
    var theUsernamePVD = "none"
    var theEmailPVD = "none"
    var theImagePVD = "none"
    
    //for storing info for accepted_service (Provider)
    var theUserAdd = "none"
    var theUserName = "none"
    var theUserUid = "none"
    var theUserPhone = "none"
    var theUserImage = "none"
    var theUserTime = "none"
    var theUserService = "none"
    var theUserServiceName = "none"
    var theUserArea = "none"
    var theUserCity = "none"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        
        datePicker?.datePickerMode = .date
        
        selectDate.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(DetailsViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        
        timePicker = UIDatePicker()
        
        timePicker?.datePickerMode = .time
        
        selectTime.inputView = timePicker
        
        timePicker?.addTarget(self, action: #selector(DetailsViewController.timeChanged(timePicker:)), for: .valueChanged)
        
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGestureTwo)
        
        navigationItem.backBarButtonItem?.tintColor = .white
        
        self.activityindicator.center = self.view.center
        
        self.activityindicator.hidesWhenStopped = true
        
        self.activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        
        self.activityindicator.startAnimating()
        
        view.addSubview(self.activityindicator)
        
        ref = Database.database().reference()
        
        DispatchQueue.main.async {
            
            self.databaseHandle = self.ref?.child("OpenService").child(self.myString).child("user_image").observe(.value, with: { (snapshot) in
                
                let thePhotoURL = snapshot.value as? String
                
                if thePhotoURL == "" {
                    
                    self.userProfileImage.image = #imageLiteral(resourceName: "default_profile_image")
                    
                } else {
                    
                    let url = NSURL(string: thePhotoURL as! String)
                    
                    let data = NSData(contentsOf: url! as URL)
                    
                    let img = UIImage(data: data! as Data)
                    
                    self.userProfileImage.image = img
                    
                }
                
            })
            
            self.databaseHandle = self.ref?.child("OpenService").child(self.myString).child("user_image").observe(.value, with: { (snapshot) in
                
                let theProbPhoto = snapshot.value as? String
                
                if theProbPhoto == "" {
                    
                    self.problemImageOne.image = #imageLiteral(resourceName: "default_profile_image")
                    
                } else {
                    
                    let url = NSURL(string: theProbPhoto as! String)
                    
                    let data = NSData(contentsOf: url! as URL)
                    
                    let img = UIImage(data: data! as Data)
                    
                    self.problemImageOne.image = img
                    
                }
                
                
            })
            
            self.databaseHandle = self.ref?.child("OpenService").child(self.myString).child("user_image").observe(.value, with: { (snapshot) in
                
                let theProbPhoto = snapshot.value as? String
                
                if theProbPhoto == "" {
                    
                    self.problemImageTwo.image = #imageLiteral(resourceName: "default_profile_image")
                    
                } else {
                    
                    let url = NSURL(string: theProbPhoto as! String)
                    
                    let data = NSData(contentsOf: url! as URL)
                    
                    let img = UIImage(data: data! as Data)
                    
                    self.problemImageTwo.image = img
                    
                }
                
                
            })
            
        }
        
        userProfileImage.layer.cornerRadius = userProfileImage.bounds.height / 2
        userProfileImage.clipsToBounds = true
        
        //trick to get single data from database
        databaseHandle = ref?.child("OpenService").child(myString).child("user_name").observe(.value, with: { (snapshot) in
            
            let theUsername = snapshot.value
            
            self.customerName.text = theUsername as? String
            
        })
        
        databaseHandle = ref?.child("OpenService").child(myString).child("Phone").observe(.value, with: { (snapshot) in
            
            let thePhone = snapshot.value
            
            self.customerPhone.text = thePhone as? String
            
        })
        
        databaseHandle = ref?.child("OpenService").child(myString).child("Address").observe(.value, with: { (snapshot) in
            
            let theAddress = snapshot.value
            
            self.customerAddress.text = theAddress as? String
            
        })
        
        databaseHandle = ref?.child("OpenService").child(myString).child("service").observe(.value, with: { (snapshot) in
            
            let theService = snapshot.value
            
            self.customerProb.text = theService as? String
            
        })
        
        self.activityindicator.stopAnimating()
        
    }

    @IBAction func btnAcceptHandler(_ sender: Any) {
        
        let verificationCode = Int(1000+arc4random_uniform(8999))
        
        let userIDPVD = Auth.auth().currentUser?.uid
        
        //let currentTime = Int(Date().timeIntervalSince1970 * 1000)
        
        //Fetching for storing in acceptedServices (Provider)

        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("user_id").observe(.value, with: { (snapshot) in
            
            self.theUserUid = (snapshot.value as? String)!
            
            print(self.theUserUid)
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("user_id").setValue(self.theUserUid)
            
            let databaseRef = Database.database().reference().child("Users").child(self.theUserUid).child("service_status").child(self.myString)
            
            databaseRef.child("user_id").setValue(self.theUserUid)
            
        })
 
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("user_name").observe(.value, with: { (snapshot) in
            
            self.theUserName = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("user_name").setValue(self.theUserName)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("user_name").setValue(self.theUserName)
            
            print(self.theUserName)
            
        })
        
         databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("user_image").observe(.value, with: { (snapshot) in
            
            self.theUserImage = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("user_image").setValue(self.theUserImage)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("user_image").setValue(self.theUserImage)
            
            print(self.theUserImage)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("time").observe(.value, with: { (snapshot) in
            
            self.theUserTime = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("time").setValue(self.theUserTime)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("time").setValue(self.theUserTime)
            
            print(self.theUserTime)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("service").observe(.value, with: { (snapshot) in
            
            self.theUserService = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("service").setValue(self.theUserService)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("service").setValue(self.theUserService)
            
            print(self.theUserService)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("service_name").observe(.value, with: { (snapshot) in
            
            self.theUserServiceName = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("service_name").setValue(self.theUserServiceName)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("service_name").setValue(self.theUserServiceName)
            
            print(self.theUserServiceName)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("city").observe(.value, with: { (snapshot) in
            
            self.theUserCity = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("city").setValue(self.theUserCity)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("city").setValue(self.theUserCity)
            
            print(self.theUserCity)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("area").observe(.value, with: { (snapshot) in
            
            self.theUserArea = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("area").setValue(self.theUserArea)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("area").setValue(self.theUserArea)
            
            print(self.theUserArea)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("Phone").observe(.value, with: { (snapshot) in
            
            self.theUserPhone = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("phone").setValue(self.theUserPhone)
            
            print(self.theUserPhone)
            
        })
        
        databaseHandle = ref?.child("Users").child(customeID).child("service_status_backup").child(myString).child("Address").observe(.value, with: { (snapshot) in
            
            self.theUserAdd = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("address").setValue(self.theUserAdd)
            
            print(self.theUserAdd)
            
        })
        
        
        
        
        
        //Fetching for storing in serviceStatus (User)
        databaseHandle = ref?.child("Providers").child(userIDPVD!).child("details").child("phoneno").observe(.value, with: { (snapshot) in
            
            self.thePhonePVD = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("phoneno").setValue(self.thePhonePVD)
            
            databaseRef2.child("pid").setValue(userIDPVD!)
            
            databaseRef2.child("estimatedate").setValue(self.selectDate.text!)
            
            databaseRef2.child("estimatetime").setValue(self.selectTime.text!)
            
            databaseRef2.child("pverificationcode").setValue(verificationCode)
            
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("phoneno").setValue(self.thePhonePVD)
            
            databaseRef.child("pid").setValue(userIDPVD!)
            
            databaseRef.child("estimatedate").setValue(self.selectDate.text!)
            
            databaseRef.child("estimatetime").setValue(self.selectTime.text!)
            
            databaseRef.child("pverificationcode").setValue(verificationCode)
            
            print(self.thePhonePVD)
            
        })
        
        databaseHandle = ref?.child("Providers").child(userIDPVD!).child("details").child("address").observe(.value, with: { (snapshot) in
            
            self.theAddPVD = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("paddress").setValue(self.theAddPVD)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("paddress").setValue(self.theAddPVD)
            
            print(self.theAddPVD)
            
        })
        
        databaseHandle = ref?.child("Providers").child(userIDPVD!).child("username").observe(.value, with: { (snapshot) in
            
            self.theUsernamePVD = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("name").setValue(self.theUsernamePVD)
            
            databaseRef2.child("Pdetails").child("name").setValue(self.theUsernamePVD)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("name").setValue(self.theUsernamePVD)
            
            databaseRef.child("Pdetails").child("name").setValue(self.theUsernamePVD)
            
            print(self.theUsernamePVD)
            
        })
        
        databaseHandle = ref?.child("Providers").child(userIDPVD!).child("useremailaddress").observe(.value, with: { (snapshot) in
            
            self.theEmailPVD = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("email").setValue(self.theEmailPVD)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("email").setValue(self.theEmailPVD)
            
            print(self.theEmailPVD)
            
        })
        
        databaseHandle = ref?.child("Providers").child(userIDPVD!).child("image").observe(.value, with: { (snapshot) in
            
            self.theImagePVD = (snapshot.value as? String)!
            
            let databaseRef2 = Database.database().reference().child("Providers_accepted_services")
                .child(userIDPVD!).child("accepted_services").child(self.myString)
            
            databaseRef2.child("image").setValue(self.theImagePVD)
            
            let databaseRef = Database.database().reference().child("Users").child(self.customeID).child("service_status").child(self.myString)
            
            databaseRef.child("image").setValue(self.theImagePVD)
            
            print(self.theImagePVD)
            
        })
        
        run(after: 4) {
            
            self.performSegue(withIdentifier: "toServicesScreen", sender: self)
         
            let databaseRef = Database.database().reference().child("OpenService")
            
            databaseRef.child(self.myString).removeValue()
            
        }
        
            
          /*  let alertController = UIAlertController(title: "Warning", message: "Please select valid date and time", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil) */
            
        
    
        
    }
    
    @objc func dateChanged(datePicker:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        selectDate.text = dateFormatter.string(from: datePicker.date)
        
        view.endEditing(true)
        
    }
    
    @objc func timeChanged(timePicker:UIDatePicker) {
        
        let timeFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "h:mm a"
        
        selectTime.text = timeFormatter.string(from: timePicker.date)
        
        view.endEditing(true)
        
    }
    
    @objc func viewTapped(gestureRecognizer:UITapGestureRecognizer) {
        
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAcceptAction(_ sender: Any) {
        
        
        
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        
        let deadline = DispatchTime.now() + .seconds(seconds)
        
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
        
    }
}
