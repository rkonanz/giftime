//
//  FBHomeViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 2/24/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class FBHomeViewController: UIViewController {

    
    @IBOutlet weak var homeTitleLable: UILabel!
    var dict : [String : AnyObject]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = CGPoint(x: 190, y: 500)
        
        view.addSubview(loginButton)
        
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    // adds the result to the dictionary declared above
                    self.dict = result as! [String : AnyObject]
                    
                    // adds the name of user to homepage title
                    self.homeTitleLable.text = "Welcome, " + (self.dict["name"] as! String)
                    
                }
            })
        }
    }

}
