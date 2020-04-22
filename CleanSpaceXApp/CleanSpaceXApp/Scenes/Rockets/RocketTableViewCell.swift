//
//  RocketTableViewCell.swift
//  CleanSpaceXApp
//
//  Created by Kurtuluş Ahmet TEMEL on 18.04.2020.
//  Copyright © 2020 Kurtuluş Ahmet TEMEL. All rights reserved.
//

import UIKit

class RocketTableViewCell: UITableViewCell {
    @IBOutlet weak var rocketName: UILabel!
    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var rocketDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
