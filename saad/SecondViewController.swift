//
//  SecondViewController.swift
//  saad
//
//  Created by saad on 3/11/19.
//  Copyright © 2019 saad. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);

        // Do any additional setup after loading the view.
        let user : AnyObject? = UserDefaults.standard.object(forKey: "user") as AnyObject

        print("Hello User\(user?.value(forKey: "token"))")

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
