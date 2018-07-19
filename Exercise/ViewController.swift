//
//  ViewController.swift
//  Exercise
//
//  Created by André Santana on 06/07/2018.
//  Copyright © 2018 André Santana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var seconds = 2

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        self .getRequestURL()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        activityIndicator.startAnimating()

    }
    
    //MARK: - Methods
    func getRequestURL() {
        
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

