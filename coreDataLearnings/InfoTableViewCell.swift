//
//  InfoTableViewCell.swift
//  coreDataLearnings
//
//  Created by Sridatta Nallamilli on 20/02/20.
//  Copyright © 2020 Sridatta Nallamilli. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var fnameLbl: UILabel!
    @IBOutlet weak var lnameLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
