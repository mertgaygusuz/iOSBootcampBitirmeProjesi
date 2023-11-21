//
//  FavoriteTableViewCell.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 21.11.2023.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
