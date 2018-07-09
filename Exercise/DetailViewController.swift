//
//  DetailViewController.swift
//  Exercise
//
//  Created by André Santana on 08/07/2018.
//  Copyright © 2018 André Santana. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var questionInformation = NSString()
    
    @IBOutlet weak var questionLabel: UILabel!
    
    //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        questionLabel.text = questionInformation as String
        
        
    }
    //MARK: - Methods
    func voteRequest(params: String) {
        
        let baseURL = "https://blissrecruitment:/questions/" //Remember to put ATS exception if the URL is not https
        
        let queryURL = baseURL + params
        
        let urlComp = NSURLComponents(string: queryURL)!
        
        print(queryURL)
        
        let request = NSMutableURLRequest(url: urlComp.url!)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type") //Optional
        request.httpMethod = "PUT"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let data = questionLabel.text?.data(using: String.Encoding.utf8)
        request.httpBody = data
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            
            if error != nil {
                
                //handle error
                // create the alert
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
                print(error!.localizedDescription)
                
            }
            else {
                
                let jsonStr = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Parsed JSON: '\(String(describing: jsonStr))'")
            }
        }
        dataTask.resume()
        
    }
    
    
    //MARK: - Button Actions
    @IBAction func backButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func voteButton(_ sender: Any) {
        
        self .voteRequest(params: questionInformation as String)
        
    }
    
    @IBAction func shareButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"ShareViewController") as! ShareViewController
        viewController.questionShareInfo = questionInformation as NSString
        self.present(viewController, animated: true)
        
    }

}
