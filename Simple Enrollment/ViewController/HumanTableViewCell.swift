//
//  HumanTableViewCell.swift
//  Simple Enrollment
//
//  Created by Alexander Roca on 7/5/20.
//  Copyright © 2020 Alexander Roca. All rights reserved.
//

import UIKit

class HumanTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var idNoLabel: UILabel!
    @IBOutlet weak var imageViewHuman: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
