//
//  HFSponsorViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/25/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit
import FlatUIKit
import Glyptodon
import Alamofire
import AlamofireImage
import SwiftyJSON

class HFSponsorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sponsorFeedArray:[HFSponsor] = [HFSponsor]()
    
    let apiURL = NSURL(string: "https://hackfsu.com/api/hackathon/get/sponsors")!
    let downloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .FIFO,
        maximumActiveDownloads: 1,
        imageCache: AutoPurgingImageCache()
    )
    var imagesArray = [UIImage]()
    
    @IBOutlet weak var sponsorTableView: UITableView!
    @IBOutlet var sponsorContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAlamo(apiURL)
        checkForContent()
        sponsorTableView.setContentOffset(CGPointZero, animated: false)
        sponsorTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        sponsorTableView.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        // Setting Navigation Bar Color
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        
        // Setting Navigation Bar Title
        self.navigationItem.title = "SPONSORS"
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary
        
        // self.sponsorTableView.tableFooterView = UIView()
        
        self.sponsorTableView.rowHeight = UITableViewAutomaticDimension
        self.sponsorTableView.estimatedRowHeight = 44.0

    }
    
    func callAlamo(url : NSURL) {
        Alamofire.request(.GET, url, encoding: .JSON).validate().responseJSON(completionHandler: {
            response in
            self.parseResults(JSON(response.result.value!), url: url)
            
        })
    }
    
    func parseResults(theJSON : JSON, url: NSURL) {
        var sponsorArray:[HFSponsor] = [HFSponsor]()
        for result in theJSON["sponsors"].arrayValue {
            let title = result["logo_link"].stringValue
            let name = result["name"].stringValue
            let order = result["order"].intValue
            let urlOfImages = NSURL(string: title)!
        
            let newSponsor = HFSponsor(name: name, level: order)
            sponsorArray.append(newSponsor)
            
            getImagesAlamo(urlOfImages)
        }
        
        self.sponsorFeedArray = sponsorArray
        self.sponsorTableView.reloadData()
    }
    
    func getImagesAlamo(url : NSURL) {
        let URLRequest = NSURLRequest(URL: url)
        downloader.downloadImage(URLRequest: URLRequest) { response in

            if let theimage = response.result.value {
                self.imagesArray.append(theimage)
            }
            else {
                let image = UIImage(named: "placeholder.png")
                self.imagesArray.append(image!)
            }
            self.sponsorTableView.reloadData()
            self.calculateImageRatios()
            self.checkForContent()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return imagesArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:HFSponsorTableViewCell = tableView.dequeueReusableCellWithIdentifier("sponsor") as! HFSponsorTableViewCell
        let sponsor:HFSponsor = sponsorFeedArray[indexPath.section]
        let thaImages = imagesArray[indexPath.section]
        cell.sponsorImage.image = thaImages
        cell.sponsorImage.contentMode = .ScaleAspectFit
        cell.sponLabel.text = sponsor.getSponsorName()
        cell.configureFlatCellWithColor(UIColor.whiteColor(), selectedColor: UIColor.whiteColor(), roundingCorners: .AllCorners)
        cell.cornerRadius = 3.5
        cell.backgroundColor = UIColor.colorFromHex(0xEDECF3)
//      cell.separatorHeight = 10.0
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if allSizesAreEvaluated() {
            let sponsor = sponsorFeedArray[indexPath.section]
            let screenWidth = UIScreen.mainScreen().bounds.width
            let screenWidthWithBorders = screenWidth - 16.0
            let sponsorImageHeight = screenWidthWithBorders * sponsor.getSponsorAspectValue() + 30.0
            return sponsorImageHeight
        } else {
            return 100.0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 6.0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 6.5))
        footerView.backgroundColor = UIColor.colorFromHex(0xEDECF3)
        
        return footerView
    }
    
    func checkForContent() {
        if allSizesAreEvaluated() == false {
            sponsorTableView.alpha = 0.0
            sponsorContainerView.glyptodon.show("Getting Sponsors. Please Wait.")
        } else {
            sponsorContainerView.glyptodon.hide()
            sponsorTableView.alpha = 1.0
        }
    }

    
    func calculateImageRatios() {
        for (sponsor,b) in zip(self.sponsorFeedArray, self.imagesArray) {
                let imageSize:CGSize = (b.size)
            
                let imageHeight:CGFloat = imageSize.height
                let imageWidth:CGFloat = imageSize.width
                let newValue = imageHeight / imageWidth
                sponsor.setSponsorAspectValue(newValue)
                sponsor.sizeWasEvaluated()
                
                if self.allSizesAreEvaluated() {
                    self.sponsorTableView.reloadData()
                    self.checkForContent()
                }
            
        }
        
    }
    
    func allSizesAreEvaluated() -> Bool {
        for sponsor in sponsorFeedArray {
            if sponsor.getSizeEvaluated() == false {
                return false
            }
        }
        return true
    }

}

    


