//
//  HFMentorViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/23/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

class HFMentorViewController: UIViewController {
    

    @IBAction func refreshView(sender: AnyObject) {
        loadwebview()
    }
    
    @IBOutlet weak var mentorView: UIView!
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Nav bar 
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.navigationItem.title = "HELP REQUEST"
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary
        self.navigationController?.navigationBar.tintColor = .whiteColor()

        loadwebview()
        webView.scrollView.bounces = false;
        
    }
    
    func loadwebview() {
        let url = NSURL (string: "https://hackfsu.com/help")
        let requestObj = NSURLRequest(URL: url!);
        webView.loadRequest(requestObj)
    }
    
}
