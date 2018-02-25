//
//  thirdHackViewController.swift
//  judgeViewTesting
//
//  Created by Andres Ibarra on 1/12/18.
//  Copyright © 2018 Andres Ibarra. All rights reserved.
//

import UIKit

class thirdHackViewController: UIViewController {
    
    @IBOutlet var superlativesTableView: UITableView!
    @IBOutlet var addSuperlativeButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var tableDescriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDescriptionLabel.text = "Go To Table #\(String(describing: givenHacks["3"]!))"
        
        tableDescriptionLabel.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/4)
        superlativesTableView.layer.position = CGPoint(x: self.view.bounds.width/2, y: self.view.bounds.height/2)
        
        addSuperlativeButton.layer.position = CGPoint(x: self.view.bounds.width/2, y: (3*self.view.bounds.height)/4)
        nextButton.layer.position =  CGPoint(x: self.view.bounds.width/2, y: ((addSuperlativeButton.bounds.height)+(3*self.view.bounds.height)/4)+10)
        
        
        superlativesTableView.delegate = self
        superlativesTableView.dataSource = self
        superlativesTableView.layer.isHidden = true
        
        superlativesTableView.layer.cornerRadius = 30.0
        superlativesTableView.layer.masksToBounds = true
        
        addSuperlativeButton.layer.cornerRadius = 30.0
        addSuperlativeButton.layer.masksToBounds = true
        
        nextButton.layer.cornerRadius = 30.0
        nextButton.layer.masksToBounds = true
        
        
    }
   
    
    @IBAction func clickedAddSuperlative(_ sender: Any) {
        superlativesTableView.reloadData()
        superlativesTableView.layer.isHidden = false
    }
    
    @IBAction func selectedSuperlative(_ sender: UIButton) {
        var deselected = false
        let cells = superlativesTableView.visibleCells as! [superlativeTableViewCell]
        
        if sender.image(for: UIControlState()) == #imageLiteral(resourceName: "circle-tick-7"){
            deselected = true
        }else{
            deselected = false
        }
        
        
        if deselected{
            for cell in cells{
                if cell.addButton == sender{
                    if let sText =  cell.superlative.text{
                        superlatives[givenHacks["3"]!]! = superlatives[givenHacks["3"]!]!.filter{$0 != sText}
                        sender.setImage(#imageLiteral(resourceName: "plus-simple-7"), for: UIControlState())
//                        print("Displaying after deletion")
//                        for x in superlatives{
//                            print(x)
//                        }
                        return
                    }
                }
            }
        }else{
            sender.setImage(#imageLiteral(resourceName: "circle-tick-7"), for: UIControlState())
            for cell in cells{
                if cell.addButton.image(for: UIControlState()) == #imageLiteral(resourceName: "circle-tick-7"){
                    if let sText =  cell.superlative.text{
                        if !superlatives[givenHacks["3"]!]!.contains(where: {$0 == sText}){
                            superlatives[givenHacks["3"]!]?.append(sText)
                        }
//                        print("Displaying after insertion")
//                        for x in superlatives{
//                            print(x)
//                        }
                    }
                }
            }
        }
    }
    
    @IBAction func clickedNext(_ sender: Any) {
//            for x in superlatives{
//            print(x)
//            }
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FinalRankingView")
            self.present(vc!, animated: true, completion: nil)
        
    }
   
    


}
extension thirdHackViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return superlativeOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superlativeCells") as! superlativeTableViewCell
        
        cell.superlative.text = superlativeOptions[indexPath.row]
        return cell
    }
}
