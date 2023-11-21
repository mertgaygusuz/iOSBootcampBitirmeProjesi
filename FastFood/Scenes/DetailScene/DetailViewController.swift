//
//  DetailViewController.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 26.10.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var viewModel = DetailViewModel()
    var chooseFood: Yemekler?
    var sepettekiUrunSayisi = 0
    var totalFiyat = 0
    var urunFiyat: Int?
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var foodPayment: UILabel!
    @IBOutlet weak var foodCount: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let food = chooseFood {
            urunFiyat = Int(food.yemek_fiyat!)
            foodImageView.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(food.yemek_resim_adi!)"))
            foodPayment.text = "\(food.yemek_fiyat!) ₺"
            foodName.text = food.yemek_adi!
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func addedFavorite(_ sender: Any) {
        if let food = chooseFood {
            viewModel.favoriyeKaydet(yemekAdi: food.yemek_adi!, yemekFiyat: food.yemek_fiyat!, yemekResimAdi: food.yemek_resim_adi!)
            alertActionMessage(title: "Favoriye eklendi", message: "Ürün başarıyla favorilere eklendi.")
        }
    }
    
    
    @IBAction func decreaseButton(_ sender: Any) {
        if sepettekiUrunSayisi > 0 {
            sepettekiUrunSayisi -= 1
            self.totalFiyat = sepettekiUrunSayisi*urunFiyat!
            foodPrice.text = "\(self.totalFiyat) ₺"
            foodCount.text = "\(sepettekiUrunSayisi)"
        }
    }
    
    @IBAction func increaseButton(_ sender: Any) {
        sepettekiUrunSayisi += 1
        self.totalFiyat = sepettekiUrunSayisi*urunFiyat!
        foodPrice.text = "\(self.totalFiyat) ₺"
        foodCount.text = "\(sepettekiUrunSayisi)"
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        if let food = chooseFood {
            
            if sepettekiUrunSayisi > 0 {
                viewModel.guncelle(yemekAdi: food.yemek_adi!, yemekResimAdi: food.yemek_resim_adi!, yemekFiyat: Int(food.yemek_fiyat!)!, yemekSiparisAdet: self.sepettekiUrunSayisi)
                alertActionMessage(title: "Ürün başarıyla eklendi", message: "Seçtiğiniz ürün başarıyla eklendi. Sepeti kontrol edebilirsiniz.")
            } else {
                alertActionMessage(title: "Ürün ekleyin", message: "En az 1 adet ürün eklemelisiniz.")
            }
        }
    }
    
    func alertActionMessage(title: String, message: String) {
        let action = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .cancel)
        action.addAction(okButton)
        self.present(action, animated: true)
    }
}
