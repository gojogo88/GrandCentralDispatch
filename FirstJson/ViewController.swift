//
//  ViewController.swift
//  FirstJson
//
//  Created by Jonathan Go on 2017/07/12.
//  Copyright © 2017 Appdelight. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    /*
    var labels = [String: UILabel]()  // dictionary
    var petitions = [String]()        // array
    */
 
    var petitions = [[String: String]]()  //the same as making the 2 var above. array of dictionaries w/ string for its key and string for its value

    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(inBackground: #selector(fetchJSON), with: nil) //the performSelector is calling the method fetchJSON
        
    }
    
    @objc func fetchJSON() {
        
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {  //this gets the json for  the most recent tab.
            
            urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            
        } else { //this gets the json for the topRated tab
            
            urlString = "https://api.whitehouse.gov/v1/petitions.json?signatureCountFloor=10000&limit=100"
        }
        
        //check if the url is valid by using if let
        if let url = URL(string: urlString) {
            //create a new data object using contentsOF method which returns the content of a URL but might throw an error like when the internet is down so we need to us the try? keyword
            if let data = try? Data(contentsOf: url) {
                //if data object was created successfully, we create a new json object from it.  Blocking call. No other code will be executed until it fully downloads the data. that is why we are using dispatchqueue to run this in the background.
                let json = JSON(data: data)
                //if there is a metadata value and it contains a responseInfo value which contains a status value, we'll return it as an integer and compare it to 200
                if json["metadata"]["responseInfo"]["status"].intValue == 200 {
                    
                    //we're ok to parse
                    self.parse(json: json)  //need self because we are inside a closure
                    
                    return
                    
                }
            }
            
        
         
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
        
    }
    
    func parse(json: JSON) {
        
        for result in json["results"].arrayValue {
            
            let title = result["title"].stringValue
            let body = result["body"].stringValue
            let sigs = result["signatureCount"].stringValue
            let obj = ["title": title, "body": body, "sigs": sigs]
            
            petitions.append(obj)
        }
        
        tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)

    }
    
    @objc func showError() {
        
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
    
        present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        
        cell.textLabel?.text = petition["title"]
        cell.detailTextLabel?.text = petition["body"]
        
        return cell
    }
    
    //this func will display the contents of the selected to to the detailedViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()  //creates an instance of DetailedViewController
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)  //pushes the data to the DetailedViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

