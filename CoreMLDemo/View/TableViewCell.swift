//
//  TableViewCell.swift
//  CoreMLDemo
//
//  Created by Максим Алексеев on 08.11.2019.
//  Copyright © 2019 AppCoda. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var emojiLabel: UILabel!
    //MARK: - Variables

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
