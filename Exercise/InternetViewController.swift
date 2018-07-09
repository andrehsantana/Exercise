//
//  InternetViewController.swift
//  Exercise
//
//  Created by André Santana on 06/07/2018.
//  Copyright © 2018 André Santana. All rights reserved.
//

import UIKit

class InternetViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tryButton: UIButton!
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityIndicator.startAnimating()
        
        self .checkInternetConnection()
 
        
    }
    
    //MARK: - Methods
    @objc func checkInternetConnection () {

        if (Reachability.isConnectedToNetwork()) {
            print("Internet Connection Available")
            self.dismiss(animated: true, completion: nil)
        } else {
            print("Internet Connection not Available")
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            tryButton.isEnabled = true
            tryButton.alpha = 1.0

        }

    }
    
    //MARK: - Button Actions
    @IBAction func tryAgain(_ sender: Any) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tryButton.isEnabled = false
        tryButton.alpha = 0.5
            
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkInternetConnection), userInfo: nil, repeats: false)
        
        
    }

}
