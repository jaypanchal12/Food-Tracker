//
//  RestaurantCell.swift
//  Food Tracker
//
//  Created by KWTMAC01 on 11/8/17.
//  Copyright © 2017 KWTMAC01. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantTitle: UILabel!
    @IBOutlet weak var restaurantSubTitle: UILabel!
    @IBOutlet weak var preparationTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
