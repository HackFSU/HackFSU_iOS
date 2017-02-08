//
//  HFSponsorTableViewCell.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 1/4/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import UIKit

class HFSponsorTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sponsorImage: UIImageView!
    @IBOutlet weak var sponLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sponsorImage.layer.cornerRadius = 3.5
        sponsorImage.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
