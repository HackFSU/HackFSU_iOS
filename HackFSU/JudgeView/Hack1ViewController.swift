//
//  Hack1.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 11/21/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class Hack1ViewController: UIViewController {

    @IBOutlet weak var hacksLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        Alamofire.request("https://api.hackfsu.com/api/judge/hacks", method: .get, parameters: nil, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
            response in
            print(response)
            
            switch response.result {
            case .success(_):
                self.parseResults(theJSON: JSON(response.result.value!))
            case .failure(_):
                print("Failed to retrive User Info")
            }
        })
    
    }
    
    func parseResults(theJSON: JSON) {
        
        var hacks = [String]()
        var superlatives = [String]()
        
        for result in theJSON["hacks"].arrayValue {
            hacks.append(result.stringValue)
        }
        
        for result in theJSON["superlatives"].arrayValue {
            superlatives.append(result.stringValue)
        }
        
        for i in hacks {
            print(i)
        }
        
        for i in superlatives {
            print(i)
        }
        
        hacksLabel.text = hacks[0] + ", " + hacks[1]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
