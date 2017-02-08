//
//  HFUpdateTableViewCell.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 11/19/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

class HFUpdateTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var timestamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
