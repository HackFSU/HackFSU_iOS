//
//  HFMapViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/23/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit
import FlatUIKit
import Agrume
import Alamofire
import AlamofireImage
import SwiftyJSON
import ReachabilitySwift

class HFMapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var floorTableView: UITableView!
    @IBOutlet var mapTableViewContainerView: UIView!
    
    let apiURL = NSURL(string: "https://hackfsu.com/api/hackathon/get/maps")!

    var imagesArray = [UIImage]()
    
    var reachability: Reachability?
    var wasntAbleToConnectFirst = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callAlamo(apiURL)
        checkForContent()
        
        floorTableView.setContentOffset(CGPointZero, animated: false)
        self.floorTableView.rowHeight = UITableViewAutomaticDimension
        self.floorTableView.estimatedRowHeight = 44.0
        
        floorTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        floorTableView.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        
        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        
        // Setting Navigation Bar Title
        self.navigationItem.title = "VENUE MAP"
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary
        
    }
    
    func callAlamo(url : NSURL) {
        Alamofire.request(.GET, url, encoding: .JSON).validate().responseJSON(completionHandler: {
            response in
            
            switch response.result {
            case .Success(let json):
                self.parseResults(JSON(response.result.value!), url: url)
            case .Failure(let error):
                if let err = error as? NSURLError where err == .NotConnectedToInternet {
                    // no internet connection
                    self.floorTableView.alpha = 0.0
                    self.mapTableViewContainerView.glyptodon.show("No Internet Connection")
                } else {
                    // other failures
                    print("fuck")
                }
                self.wasntAbleToConnectFirst = true
            }

            
        })
    }
    
    func parseResults(theJSON : JSON, url: NSURL) {
            for result in theJSON["maps"].arrayValue {
                let title = result["link"].stringValue
                let order = result["order"].intValue
                
                let urlOfImages = NSURL(string: title)!
                
                getImagesAlamo(urlOfImages)

            }
    }
    
    func getImagesAlamo(url : NSURL) {
        Alamofire.request(.GET, url).responseImage {
            response in
            
            let theimage = response.result.value!
            self.imagesArray.append(theimage)
            
            self.floorTableView.reloadData()
            self.checkForContent()
        }
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        //checkForContent()
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:",name: ReachabilityChangedNotification,object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
        
    }
    
    func reachabilityChanged(note: NSNotification) {
        
        let reachability = note.object as! Reachability
        
        if reachability.isReachable() && wasntAbleToConnectFirst == true {
            checkForContent()
            self.imagesArray.removeAll()
            callAlamo(apiURL)
            wasntAbleToConnectFirst = false
        } else {
            print("Network not reachable")
        }
    }
    
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6.0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return imagesArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell:HFMapTableViewCell = tableView.dequeueReusableCellWithIdentifier("map") as! HFMapTableViewCell
   
        let thaImages = imagesArray[indexPath.section]
        cell.mapImage.image = thaImages
        
        cell.mapImage.contentMode = .ScaleAspectFit
        cell.selectionStyle = .None
        cell.configureFlatCellWithColor(UIColor.whiteColor(), selectedColor: UIColor.whiteColor(), roundingCorners: .AllCorners)
        cell.cornerRadius = 3.5
        cell.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        cell.separatorHeight = 10.0
        return cell
    }
    
    func checkForContent() {
        if imagesArray.count == 0 {
            floorTableView.alpha = 0.0
            mapTableViewContainerView.glyptodon.show("Loading Maps.\nPlease Wait.")
        } else {
            mapTableViewContainerView.glyptodon.hide()
            floorTableView.alpha = 1.0
            
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 6.5))
        footerView.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        
        return footerView
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let thaImages = imagesArray[indexPath.section]
        let agrume = Agrume(image: thaImages)
        agrume.showFrom(self)
    }
}
    

