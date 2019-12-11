//
//  MomentCell.swift
//  Moments2
//
//  Created by Usuario invitado on 10/12/19.
//  Copyright © 2019 Usuario invitado. All rights reserved.
//

import UIKit

class MomentCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
