//
//  ItemTableViewCell.swift
//  SportsStore
//
//  Created by Ray Foote on 12/13/15.
//  Copyright © 2015 fierlion. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var productId:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
