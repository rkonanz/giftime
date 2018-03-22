//
//  AccountSettingsViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 3/20/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class AccountSettingsViewController: UIViewController {

    var dict : [String : AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add Facebook button to view
        let myLogOutButton = UIButton(type: .custom)
        myLogOutButton.frame = CGRect(x: 35, y: 185, width: 300, height: 50)
        myLogOutButton.setTitle("Log Out", for: .normal)
        myLogOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        myLogOutButton.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        let red = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        myLogOutButton.layer.cornerRadius = 15
        myLogOutButton.layer.backgroundColor = UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 0.15).cgColor
        myLogOutButton.layer.borderColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.25).cgColor
        myLogOutButton.layer.borderWidth = 1
        
        // handle clicks on the button
        myLogOutButton.addTarget(self, action:#selector(logOutButtonClicked), for: .touchUpInside)
        
        // adding it to view
        view.addSubview(myLogOutButton)
        
        // gets the Facebook User data
        if let accessToken = FBSDKAccessToken.current(){
            getFBUserData()
        }

    }
    
    //when log out button clicked
    @objc func logOutButtonClicked() {
        
        // Create the AlertController
        let actionSheetController = UIAlertController(title: "Warning", message: "Are you sure you want to Log Out?", preferredStyle: .actionSheet)
        
        // Create and add the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            // Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        
        // Create and add first option action
        let logOutAction = UIAlertAction(title: "Yes, Log Out", style: .default) { action -> Void in
            self.performSegue(withIdentifier: "accountLoggedOut", sender: self)
        }
        actionSheetController.addAction(logOutAction)
        
        // Present Alert
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    // Function to fetch Facebook User data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    // adds the result to the dictionary declared above
                    self.dict = result as! [String : AnyObject]
                }
            })
        }
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
