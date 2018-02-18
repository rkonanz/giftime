//
//  FBLogInViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 2/11/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit
import FacebookLogin

class FBLogInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
