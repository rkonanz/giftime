//
//  PopUpCodeViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 3/22/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit

class PopUpCodeViewController: UIViewController {
    
    let URL_IMAGE = URL(string: "http://www.wegotyouagift.com/images/pizza.png")
    
    @IBOutlet weak var giftImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .default)
        
        // create a dataTask
        let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
            
            // check if there is any error
            if let e = error {
                
                // display error message
                print("Error occurred: \(e)")
                
            } else {
                
                // in case of no error, check whether response is nil or not
                if (response as? HTTPURLResponse) != nil {
                    
                    // checking if the response contains an image
                    if let imageData = data {
                        
                        // getting the image
                        let image = UIImage(data: imageData)
                        
                        // displaying the image
                        DispatchQueue.main.async {
                            self.giftImage.image = image
                        }
                        print("EVERYTHING IS GOOD ON THIS SIDE")
                        
                    } else {
                        print("Image file is corrupted")
                    }
                } else {
                    print("No response from server")
                }
            }
        }
        
        //starting the download task
        getImageFromUrl.resume()
        
    }
    
    @IBAction func closePopUp(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    
    }
    

}
