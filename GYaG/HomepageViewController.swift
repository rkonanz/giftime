//
//  HomepageViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 1/13/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var homeTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://www.wegotyouagift.com/validation/homepageFB.php")!
        let request = URLRequest(url: url)
        
        // modify the request as necessary, if necessary
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            
            var fbName = ""
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let name = json["name"]{
                    print("name = \(name)")
                    fbName = name
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(responseString)")
            }
            
            DispatchQueue.main.async {
                self.homeTitle.text = fbName as String?!
            }
            
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        let url = URL(string: "http://www.wegotyouagift.com/validation/logOut.php")!
        let request = URLRequest(url: url)
        
        // modify the request as necessary, if necessary
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
        }
        task.resume()
        
    }
    
    
}
