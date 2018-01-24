//
//  RegisterViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 1/12/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(_ sender: Any) {
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://www.wegotyouagift.com/registerUser.php")! as URL)
        request.httpMethod = "POST"
        //need to add the other two variables in here and in php to register user successfully
        let postString = "a=\(email.text!)&b=\(password.text!)&c=\(firstName.text!)&d=\(lastName.text!)"
        
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
        
        self.performSegue(withIdentifier: "registeredToLogin", sender: self)
        
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
