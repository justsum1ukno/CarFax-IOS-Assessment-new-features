//
//  listingViewCellTableViewCell.swift
//  IOS Assessment
//
//  Created by Justin Edwards on 8/7/19.
//  Copyright © 2019 apps. All rights reserved.
//

import UIKit


class listingViewTableCell: UITableViewCell{
   
   
    @IBOutlet weak var listingPhoto: UIImageView!
    @IBOutlet weak var listingYear_Label: UILabel!
    @IBOutlet weak var listingMake_Label: UILabel!
    @IBOutlet weak var listingModel_Label: UILabel!
    @IBOutlet weak var listingPrice_Label: UILabel!
    @IBOutlet weak var listingMileage_Label: UILabel!
    @IBOutlet weak var listingLocation_Label: UILabel!
    @IBOutlet weak var divider: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
} 

