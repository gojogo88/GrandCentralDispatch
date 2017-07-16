//
//  DetailViewController.swift
//  FirstJson
//
//  Created by Jonathan Go on 2017/07/15.
//  Copyright © 2017 Appdelight. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var webView: WKWebView!
    var detailItem: [String: String]!
    
    override func loadView() {
        
        webView = WKWebView()
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //guard sets it so the code exits immediately if critical data is missing. Meaning we dont want this to run if the detailItem isn't set so the guard statement will protect us and just run return if the detailItem is set to nil.
        guard detailItem != nil else { return }
            
            if let body = detailItem["body"] {
                
                var html = "<html>"
                html += "<head>"
                html += "<meta name=\"viewport\" content\"width=device-width, initial-scale=1\">"
                html += "<style> body { font-size: 150%; } </style>"
                html += "</head>"
                html += "<body>"
                html += body
                html += "</body>"
                html += "<html>"
                
                webView.loadHTMLString(html, baseURL: nil)
            }
        }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
