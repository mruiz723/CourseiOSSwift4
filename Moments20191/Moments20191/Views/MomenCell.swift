//
//  MomenCell.swift
//  Moments20191
//
//  Created by Usuario invitado on 13/6/19.
//  Copyright © 2019 eafit. All rights reserved.
//

import UIKit

class MomenCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var momentImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}