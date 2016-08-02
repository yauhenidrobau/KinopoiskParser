//
//  NewsTableViewCell.swift
//  KinopoiskParser
//
//  Created by Admin on 02.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

   
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var desctiptionLabel: UILabel!
    
    @IBOutlet weak var imageNewsView: UIImageView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
