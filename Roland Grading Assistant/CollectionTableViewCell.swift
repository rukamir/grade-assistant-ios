//
//  CollectionTableViewCell.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 5/5/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    // MARK: Properties
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
