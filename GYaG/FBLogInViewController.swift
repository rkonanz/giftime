//
//  FBLogInViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 2/11/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//
import UIKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin

class FBLogInViewController: UIViewController{
    
    
    @IBOutlet weak var emailLabel: UILabel!
    var dict : [String : AnyObject]!
    
    //sets bg image to fb login button
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add Facebook button to view
        let myLoginButton = UIButton(type: .custom)
        myLoginButton.frame = CGRect(x: 38, y: 405, width: 300, height: 50)
        myLoginButton.setTitle("Continuar con Facebook", for: .normal)
        myLoginButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        let red = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        myLoginButton.layer.cornerRadius = 15
        myLoginButton.layer.borderColor = red.cgColor
        myLoginButton.layer.borderWidth = 2
        
        // handle clicks on the button
        myLoginButton.addTarget(self, action:#selector(loginButtonClicked), for: .touchUpInside)
        
        //adding it to view
        view.addSubview(myLoginButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //when login button clicked
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                //print("Success!")
                //self.getFBUserData()
                self.performSegue(withIdentifier: "fbLoggedIn", sender: self)
            }
        }
    }
    
    
    //function is fetching the user data
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
    }
    
    // defines an alert message
    func displayAlertMessage(title:String,message:String)
    {
        let alertController = UIAlertController(title:title, message:message, preferredStyle:UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        alertController.addAction(okAction);
        self.present(alertController, animated:true, completion:nil);
        
    }

}
