//
//  ListViewController.swift
//  Exercise
//
//  Created by André Santana on 06/07/2018.
//  Copyright © 2018 André Santana. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var questionsArray : NSMutableArray = []
    var recordsValue : NSInteger = 10
    
    let cellReuseIdentifier = "myCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        searchBar.showsScopeBar = true
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
  
        questionsArray.add("Question 1")
        questionsArray.add("Question 2")
        questionsArray.add("Question 3")
        questionsArray.add("Question 4")
        questionsArray.add("Question 5")
        questionsArray.add("Question 6")
        questionsArray.add("Question 7")
        questionsArray.add("Question 8")
        questionsArray.add("Question 9")
        questionsArray.add("Question 10")
        questionsArray.add("Question 11")
        questionsArray.add("Question 12")
        questionsArray.add("Question 13")
        questionsArray.add("Question 14")
        questionsArray.add("Question 15")
        questionsArray.add("Question 16")
        questionsArray.add("Question 17")
        questionsArray.add("Question 18")
        questionsArray.add("Question 19")
        questionsArray.add("Question 20")
        questionsArray.add("Question 21")
        
        print(questionsArray)
           
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        if let path = tableView.indexPathForSelectedRow {

            tableView.deselectRow(at: path, animated: true)
        }
    }
    
    func getRequest(params: String) {
        
        let baseURL = "https://blissrecruitment://questions?question_filter="
        
        let queryURL = baseURL + params
        
        let urlComp = NSURLComponents(string: queryURL)!
        
        print(queryURL)
        
        var items = [URLQueryItem]()
        
        items = items.filter{!$0.name.isEmpty}
        
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as Any)
            
        })
        task.resume()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 1;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return recordsValue;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: cellReuseIdentifier)
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
       
        cell.textLabel?.text = questionsArray[indexPath.row] as? String
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier :"DetailViewController") as! DetailViewController
        viewController.questionInformation = questionsArray[indexPath.row] as! NSString
        self.present(viewController, animated: true)

    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        self .getRequest(params: searchBar.text!)
    }
    
    @IBAction func recordsButton(_ sender: Any) {
        
        recordsValue = recordsValue + 10
        
        print(questionsArray.count, recordsValue)
        
        if(questionsArray.count < recordsValue) {
            recordsValue = questionsArray.count
            tableView.reloadData()
            print("No more records to load!")
        }
        else {
            tableView.reloadData()
        }
        
    }

}
