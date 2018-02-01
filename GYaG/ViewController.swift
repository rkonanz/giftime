//
//  ViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 1/9/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

