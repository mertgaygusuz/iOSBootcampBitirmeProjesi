//
//  CartTableViewCell.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 31.10.2023.
//

import UIKit
import Kingfisher

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodCount: UILabel!
    @IBOutlet weak var foodTotalPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setData(secilenYemek: SepettekiYemekler!) {
        if let yemek = secilenYemek {
            let totalPrice = Int(yemek.yemek_fiyat!)! * Int(yemek.yemek_siparis_adet!)!
            foodName.text = yemek.yemek_adi!
            foodImage.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(secilenYemek.yemek_resim_adi!)"))
            foodPrice.text = "\(yemek.yemek_fiyat!) ₺"
            foodCount.text = "\(yemek.yemek_siparis_adet!)"
            foodTotalPrice.text = "\(totalPrice) ₺"
        }
    }

}
