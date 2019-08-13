//
//  CourseViewCell.swift
//  currencyApp
//
//  Created by Мак on 8/13/19.
//  Copyright © 2019 Aidar Zhussupov. All rights reserved.
//

import UIKit

class CourseViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imageFlag: UIImageView!
    
    @IBOutlet weak var labelCurrencyName: UILabel!
    @IBOutlet weak var labelCourse: UILabel!
    
    func initCell(currency: Currency){
        imageFlag.image = currency.imageFlag
        labelCurrencyName.text = currency.fullname
        labelCourse.text = currency.description
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
