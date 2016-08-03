//
//  DetailsViewController.swift
//  KinopoiskParser
//
//  Created by Admin on 01.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var newsUrl: NSURL!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.hidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if newsUrl != nil {
           var request: NSURLRequest = NSURLRequest(URL: newsUrl)
            webView.loadRequest(request)
        }
        if webView.hidden {
            webView.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
    // MARK: - Navigation



}
