//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Radya Albasha on 8/1/19.
//  Copyright © 2019 Ember. All rights reserved.
//

import UIKit
import SDWebImage
class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    
    @IBOutlet weak var headLineLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        headLineLabel.adjustsFontSizeToFitWidth = true
       // UIMethodsClass.roundedView(rView: self.contentView, radius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(headLine : String , date : String , imageURL : String?)
    {
        self.headLineLabel.text  = headLine
        self.dateLabel.text = date
        if imageURL != nil{
         self.logoImageView.sd_setImage(with: URL(string: imageURL!), placeholderImage: UIImage(named:"NewsPaper" ))
        }
    }
    
}
