//
//  FavoriteViewModel.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 21.11.2023.
//

import Foundation
import RxSwift

class FavoriteViewModel {
    var favoriteRepo = FavoriteRepository()
    var favorilerListesi = BehaviorSubject<[YemeklerModel]>(value: [YemeklerModel]())
    
    init(){
        favorilerListesi = favoriteRepo.favorilerListesi
        favorileriYukle()
    }
    
    func ara(arananKelime: String){
        favoriteRepo.ara(arananKelime: arananKelime)
    }
    
    func sil(yemek: YemeklerModel){
        favoriteRepo.favoriSil(yemek: yemek)
    }
    
    func favorileriYukle(){
        favoriteRepo.favorileriYukle()
    }
}
