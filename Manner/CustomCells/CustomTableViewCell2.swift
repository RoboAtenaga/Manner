//
//  CustomTableViewCell2.swift
//  Manner
//
//  Created by Robo Atenaga on 2/2/18.
//  Copyright © 2018 Robo Atenaga. All rights reserved.
//

import UIKit

class CustomTableViewCell2: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
