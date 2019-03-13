//
//  ViewController.swift
//  saad
//
//  Created by saad on 3/11/19.
//  Copyright © 2019 saad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var errorText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }

    @IBAction func loginButton(_ sender: Any) {
        print("Hello Jee")
        let myText1 = email.text
        var mytext2 = password.text
        print("1 is \(myText1) 2 is \(mytext2)")
        
        let parameters = ["email_address": myText1, "password": mytext2] as [String : Any]
        
        //create the url with URL
        let url = URL(string: "https://dev.saayahealth.com:8000/o/token")! //change the url
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                //create json object from data
                print(json)
                if let myDictionary = json
                {
                    if (myDictionary["non_field_errors"] != nil){
                        var error = myDictionary["non_field_errors"]
                        print(" Error :\(error)")
                        
                        DispatchQueue.main.async {
                            // UIView usage
                            self.errorText.text = "Unable to log in with provided credentials"
                            self.errorText.isHidden = false
                        }
                 
                    }
                    else{
                        UserDefaults.standard.set(json, forKey: "user")
                        DispatchQueue.main.async {
                            // UIView usage
                            self.errorText.isHidden = true
                            let homeView = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                            self.navigationController?.pushViewController(homeView, animated: true)
                            
                        }
                     

                        print("Login Succesfull")
                    }
                }
            } catch let error {
                print("error",error.localizedDescription)
            }
        })
        task.resume()
    }

    
}

