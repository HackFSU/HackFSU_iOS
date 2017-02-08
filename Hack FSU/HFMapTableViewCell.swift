//
//  TableViewCell.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 12/16/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

class HFMapTableViewCell: UITableViewCell {

    @IBOutlet weak var mapImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mapImage.layer.cornerRadius = 3.5
        mapImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
