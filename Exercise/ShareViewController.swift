//
//  ShareViewController.swift
//  Exercise
//
//  Created by André Santana on 09/07/2018.
//  Copyright © 2018 André Santana. All rights reserved.
//

import UIKit
import MessageUI

class ShareViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var questionShareInfo = NSString()
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
     //MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self .setupUI()
        
    }
    
    //MARK: - UI updates
    func setupUI() {
        
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 2.0
        textView.text = questionShareInfo as String
        
    }

    //MARK: - Methods
    func sendEmail() {
        
        if (emailTextField.text == nil) { emailTextField.text = "" }
        
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["email": emailTextField.text!, "message": textView.text!]
        
        //create the url with NSURL
        let urlString = "http://blissrecruitment:/share?destination_email=" + parameters["email"]! + "&content_url=" + parameters["message"]!
        
        if let encoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed),
            let myURL = URL(string: encoded) {
            print(myURL)
        }
        
        guard let url = NSURL(string: urlString) else {
            print("Error")
            return
        }
        
        //create the session object
        let session = URLSession.shared
        
        //now create the NSMutableRequest object using the url object
        var request = URLRequest(url: url as URL)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: AnyObject] {
                    print(json)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
            
        })
        
        task.resume()
    }
    
    //MARK: - Method to create a Mail sender
//    func sendEmail() {
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients([emailTextField.text!])
//            mail.setMessageBody(textView.text, isHTML: false)
//
//            present(mail, animated: true)
//        } else {
//
//            // create the alert
//            let alert = UIAlertController(title: "Error", message: "Some error occurred", preferredStyle: UIAlertControllerStyle.alert)
//
//            // add an action (button)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//            self.navigationController? .popToRootViewController(animated: true)
//
//            // show the alert
//            self.present(alert, animated: true, completion: nil)
//
//        }
//    }
    
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
//
    
     //MARK: - Button Actions
    @IBAction func sendButton(_ sender: Any) {
        
        
        self .sendEmail()
        
    }
}
