//
//  DetailsViewController.swift
//  KinopoiskParser
//
//  Created by Admin on 01.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
   
    @IBOutlet weak var activityInd: UIActivityIndicatorView!
    
    var newsUrl: NSURL!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.hidden = true
       
    }
    
    override func viewDidAppear(animated: Bool) {
       activityInd.hidden = true
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
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityInd.hidden = false
        activityInd.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityInd.hidden = true
        activityInd.stopAnimating()
    }
   
}
