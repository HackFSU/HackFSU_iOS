//
//  EventSelectionViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 2/1/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit

var eventList = Dictionary<String, String>()

class EventSelectionViewController: UIViewController {

    @IBOutlet var eventTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventTable.delegate = self
        eventTable.dataSource = self

        
    }


}


extension EventSelectionViewController: UITableViewDataSource,UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/CGFloat(eventList.count)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! eventListTableCell
        
        cell.eventLabel.text = eventList[String(indexPath.row+1)]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "scanner")
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    
}


class eventListTableCell: UITableViewCell{
    
    @IBOutlet var eventLabel: UILabel!
    
    
}
