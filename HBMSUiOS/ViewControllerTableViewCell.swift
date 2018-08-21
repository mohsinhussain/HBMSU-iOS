//
//  ViewControllerTableViewCell.swift
//  HBMSUiOS
//
//  Created by Mohsin Hussain on 8/22/18.
//  Copyright © 2018 Mohsin Hussain. All rights reserved.
//

import UIKit


class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var dateName: UILabel!
    @IBOutlet weak var tempName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
