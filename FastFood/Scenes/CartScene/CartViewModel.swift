//
//  CartViewModel.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 31.10.2023.
//

import Foundation
import RxSwift

class CartViewModel {
    var sepetRepo = CartRepository()
    var sepetListesi = BehaviorSubject<[SepettekiYemekler]>(value: [SepettekiYemekler]())

    
    init(){
        sepetListesi = sepetRepo.sepetListesi
        sepetiYukle()
    }
    
    func totalPriceCalculation(sepetList: [SepettekiYemekler]) -> Int{
        var yemekTotal = 0
        for sepetYemek in sepetList {
            let yemekAdet = Int(sepetYemek.yemek_siparis_adet!)!
            let yemekFiyat = Int(sepetYemek.yemek_fiyat!)!

            let yemekToplamFiyat = yemekAdet * yemekFiyat
            yemekTotal += yemekToplamFiyat
        }
        return yemekTotal
    }
    
    func sepetiYukle() {
        sepetRepo.sepettekiYemekleriYukle()
    }
    
    func sepetiSil(yemekId: Int, kullaniciAdi: String){
        sepetRepo.sepetiSil(yemek_id: yemekId, kullanici_adi: kullaniciAdi)
    }
}
