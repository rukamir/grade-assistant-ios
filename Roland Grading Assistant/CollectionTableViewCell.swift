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
    @IBOutlet weak var qCount: UILabel!
    @IBOutlet weak var rectView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rectView.layer.frame = CGRect(x: 2.0, y: 2.0, width: 364, height: 70)
        rectView.layer.shadowRadius = 10.0
        rectView.layer.shadowOpacity = 0.7
        rectView.layer.shadowRadius = 5.0
        
        rectView.layer.cornerRadius = 5.0
        rectView.layer.borderWidth = 5.0
        rectView.layer.borderColor = UIColor.purple.cgColor
        
        rectView.layer.backgroundColor = UIColor.white.cgColor
        
        /*// Bottom
        var longBottom = CALayer()
        longBottom.frame = CGRect(x: 2.0, y: 26.0, width: 360, height: 38)
        longBottom.backgroundColor = UIColor.white.cgColor
        rectView.layer.addSublayer(longBottom)
        */
 
        // Top left box
        var topLeft = CALayer()
        topLeft.frame = CGRect(x: 2.0, y: 2.0, width: 175, height: 25)//(rectView.layer.frame, 20, 20)
        topLeft.contentsGravity = kCAFilterLinear
        topLeft.backgroundColor = UIColor.init(red: 240.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        topLeft.borderColor = UIColor.purple.cgColor
        topLeft.borderWidth = 2.0
        rectView.layer.addSublayer(topLeft)
        
        // Top Right
        var topRight = CALayer()
        topRight.frame = CGRect(x: 177.0, y: 2.0, width: 185.0, height: 25)
        topRight.contentsGravity = kCAFilterLinear
        topRight.backgroundColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
        topRight.borderColor = UIColor.purple.cgColor
        topRight.borderWidth = 2.0
        rectView.layer.addSublayer(topRight)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
