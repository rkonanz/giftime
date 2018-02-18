//
//  ViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 1/9/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var permissionsLabel: UILabel!
    @IBOutlet weak var accessTokenLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // login for Facebook
    @IBAction func fbLogin(_ sender: Any) {
    
        let loginManager = LoginManager()
        
        loginManager.logIn([.publicProfile, .email], viewController: self){
            result in
            
            switch result {
            case .failed(let error):
                print(error.localizedDescription)
            case .cancelled:
                print("cancelled")
            case .success(_,_,_):
                self.getUserInfo { userInfo, error in
                    if let error = error { print(error.localizedDescription) }
                    
                    if let userInfo = userInfo, let id = userInfo["id"], let name = userInfo["name"], let email = userInfo["email"] {
                        
                        let request = NSMutableURLRequest(url: NSURL(string: "http://www.wegotyouagift.com/validation/fbRegister.php")! as URL)
                        request.httpMethod = "POST"
                        //need to add the other two variables in here and in php to register user successfully
                        let postString = "a=\(email)&b=\(name)"
                        
                        request.httpBody = postString.data(using: String.Encoding.utf8)
                        
                        let task = URLSession.shared.dataTask(with: request as URLRequest) {
                            data, response, error in
                            
                            if error != nil {
                                print("error=\(error)")
                                return
                            }
                            
                        }
                        task.resume()
                        print("No errors")
                        
                        self.performSegue(withIdentifier: "loggedInToHome", sender: self)
                    }
                }
            }
        }
        
    }
    
    // gets user information from Facebook
    func getUserInfo(completion: @escaping (_ : [String: Any]?, _ : Error?) -> Void){
        
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "id,name,email,picture"])
        request.start { response, result in
            switch result {
            case .failed(let error):
                completion(nil, error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }
        }
        
    }
    
    
    @IBAction func logIn(_ sender: Any) {
        
        // checks if email or password are empty
        if email.text! == "" || password.text! == "" {
            self.displayAlertMessage(title: "Error", message: "No Blank Fields Allowed!")
            return
        }
        
        // selects PHP script and starts the request
        let url = URL(string: "http://www.wegotyouagift.com/validation/loginUser.php")!
        var request = URLRequest(url: url)
        
        // makes the request a POST method
        request.httpMethod = "POST"
        
        // gives the Post String variables
        let postString = "a=\(email.text!)&b=\(password.text!)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        // starts the Task and Request of sharing data
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            // stores the password received by server
            var receivedPass = ""
            
            // tries to read JSON
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let password = json["password"]{
                    print("password = \(password)")
                    receivedPass = password
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(responseString)")
            }
            
            // does changes in UI based on HTTP request
            DispatchQueue.main.async {
                if self.password.text! == receivedPass {
                    print("Login Successful")
                    // sends to homepage
                    self.performSegue(withIdentifier: "loggedInToHome", sender: self)
                }
                else{
                    // shows alert for wrong user/password
                    print("Wrong User/Password")
                    self.displayAlertMessage(title: "Error", message: "Wrong User/Password!")
                    
                }
            }
            
        }
        task.resume()
        
    }
    
    func displayAlertMessage(title:String,message:String)
    {
        let alertController = UIAlertController(title:title, message:message, preferredStyle:UIAlertControllerStyle.alert);
        let okAction = UIAlertAction(title:"Ok", style:UIAlertActionStyle.default, handler:nil);
        alertController.addAction(okAction);
        self.present(alertController, animated:true, completion:nil);
        
    }
    
}

