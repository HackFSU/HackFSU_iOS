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

    @IBOutlet var returnButton: UIButton!
    @IBOutlet weak var hacksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       //ANDRES
        returnButton.layer.borderWidth = 3
        returnButton.layer.cornerRadius = 15
        returnButton.layer.masksToBounds = true
        returnButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        
        
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
    
    
    
}
