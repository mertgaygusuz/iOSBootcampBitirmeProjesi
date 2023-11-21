//
//  DetailViewModel.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 31.10.2023.
//

import Foundation

class DetailViewModel {
    var yemeklerRepo = FoodRepository()
    var favoriteRepo = FavoriteRepository()
    
    func guncelle(yemekAdi: String, yemekResimAdi: String, yemekFiyat: Int, yemekSiparisAdet: Int) {
        yemeklerRepo.kaydet(yemek_adi: yemekAdi, yemek_resim_adi: yemekResimAdi, yemek_fiyat: yemekFiyat, yemek_siparis_adet: yemekSiparisAdet)
    }
    
    func favoriyeKaydet(yemekAdi: String, yemekFiyat: String, yemekResimAdi: String){
        favoriteRepo.favoriKaydet(yemekAdi: yemekAdi, yemekFiyat: yemekFiyat, yemekResimAdi: yemekResimAdi)
    }
}
