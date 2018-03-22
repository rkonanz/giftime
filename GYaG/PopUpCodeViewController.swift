//
//  PopUpCodeViewController.swift
//  GYaG
//
//  Created by Roberto Konanz on 3/22/18.
//  Copyright © 2018 Roberto Konanz. All rights reserved.
//

import UIKit

class PopUpCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.cornerRadius = 5;
        view.layer.masksToBounds = true;

    }
    
    @IBAction func closePopUp(_ sender: Any) {
    
        dismiss(animated: true, completion: nil)
    
    }
    

}
