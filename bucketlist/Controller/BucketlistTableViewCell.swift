//
//  BucketlistTableViewCell.swift
//  bucketlist
//
//  Created by Clement  Wekesa on 26/06/2018.
//  Copyright © 2018 Clement  Wekesa. All rights reserved.
//

import UIKit

class BucketlistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var bucketlistTitle: UILabel!
    @IBOutlet weak var bucketlistComplete: UILabel!
    @IBOutlet weak var bucketlistProgress: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
