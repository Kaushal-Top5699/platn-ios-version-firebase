//
//  ViewController.swift
//  PlatNProvider
//
//  Created by < this_is_kaushal__/> on 7/30/18.
//  Copyright © 2018 < this_is_kaushal__/>. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var mEmail: UITextField!
    
    @IBOutlet var mPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    @IBAction func btnLogIn(_ sender: Any) {
        
        if mEmail.text != "" && mPassword.text != nil {
            
            Auth.auth().signIn(withEmail: mEmail.text!, password: mPassword.text!) { user, error in
                
                if error == nil && user != nil {
                    
                    print("Authentication Successfull")
                    //self.dismiss(animated: false, completion: nil)
                    print(Auth.auth().currentUser?.email! as Any)
                    self.performSegue(withIdentifier: "toHome", sender: self)
                    
                } else {
                    
                    print("Error:\(error?.localizedDescription)")
                    
                    self.resetForm()
                }
                
            }
            
        }
        
    }
    
    func resetForm() {
        
        //Alert Box
        let alert = UIAlertController(title: "Error", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }

}

