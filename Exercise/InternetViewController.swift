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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        activityIndicator.startAnimating()
        
        self .checkInternetConnection()
 
        
    }

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
    
    @IBAction func tryAgain(_ sender: Any) {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        tryButton.isEnabled = false
        tryButton.alpha = 0.5
            
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(checkInternetConnection), userInfo: nil, repeats: false)
        
        
    }
    
    @objc func getRequestURL() {
        
        let url = URL(string: "https://private-bbbe9-blissrecruitmentapi.apiary-mock.com/health")
        
        let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in
            
            guard let data = data, error == nil else { return }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewController(withIdentifier :"ListViewController") as! ListViewController
                    self.present(viewController, animated: true)
                    
                }
            } catch let error {
                // create the alert
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.navigationController? .popToRootViewController(animated: true)
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
            }
            
            print(NSString(data: data, encoding: String.Encoding.utf8.rawValue) as Any)
        }
        
        task.resume()
        
    }
    
    

}
