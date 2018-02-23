//
//  EventSelectionViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 2/1/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit

var eventList = [String]()
var eventId = Dictionary<String, String>()

class EventSelectionViewController: UIViewController {

    @IBOutlet var eventTable: UITableView!
    
    @IBOutlet var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.delegate = self
        eventTable.dataSource = self
        
        returnButton.layer.borderWidth = 3
        returnButton.layer.cornerRadius = 15
        returnButton.layer.masksToBounds = true
        returnButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)


        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let index = self.eventTable.indexPathForSelectedRow{
            eventTable.deselectRow(at: index, animated: true)
        }
        
    }
    


}


extension EventSelectionViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var sizeofCells = tableView.bounds.height/CGFloat(eventList.count)
        if sizeofCells  < CGFloat(20){
            sizeofCells = CGFloat(40)
        }
        
        return sizeofCells
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! eventListTableCell
        
        cell.eventLabel.text = eventList[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "scanner") as! ScannerViewController
        
        vc.id = Int(eventId[eventList[indexPath.row]]!)!
        print(vc.id)
       
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
}


class eventListTableCell: UITableViewCell{
    
    @IBOutlet var eventLabel: UILabel!
    
    
}
