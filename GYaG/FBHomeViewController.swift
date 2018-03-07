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
        
        // add Facebook button to view
        let myLogOutButton = UIButton(type: .custom)
        myLogOutButton.frame = CGRect(x: 60, y: 600, width: 250, height: 50)
        myLogOutButton.setTitle("Log Out", for: .normal)
        myLogOutButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        myLogOutButton.setTitleColor(UIColor(red: 0.43, green: 0.84, blue: 0.8, alpha: 1), for: .normal)
        let red = UIColor(red: 0.43, green: 0.84, blue: 0.8, alpha: 1)
        myLogOutButton.layer.borderColor = red.cgColor
        myLogOutButton.layer.borderWidth = 2
        
        // handle clicks on the button
        myLogOutButton.addTarget(self, action:#selector(logOutButtonClicked), for: .touchUpInside)
        
        //adding it to view
        view.addSubview(myLogOutButton)
        
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when log out button clicked
    @objc func logOutButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logOut()
        self.performSegue(withIdentifier: "fbLoggedOut", sender: self)
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
