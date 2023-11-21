//
//  HomeViewModel.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 28.10.2023.
//

import Foundation
import RxSwift

class HomeViewModel {
    var yemeklerRepo = FoodRepository()
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    init(){
        yemeklerListesi = yemeklerRepo.yemeklerListesi
        yemekleriYukle()
    }
    
    func yemekleriYukle() {
        yemeklerRepo.yemekleriYukle()
    }
}
