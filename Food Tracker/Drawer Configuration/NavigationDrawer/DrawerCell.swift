//
//  DrawerCell.swift
//  Food Tracker
//
//  Created by KWTMAC01 on 11/7/17.
//  Copyright © 2017 KWTMAC01. All rights reserved.
//

import UIKit

class DrawerCell: UITableViewCell {

    @IBOutlet weak var imgController: UIImageView!
    @IBOutlet weak var lblController: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
