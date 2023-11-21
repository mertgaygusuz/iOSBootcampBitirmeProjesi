//
//  FavoriteRepository.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 21.11.2023.
//

import Foundation
import Alamofire
import RxSwift
import CoreData

class FavoriteRepository {
    var favorilerListesi = BehaviorSubject<[YemeklerModel]>(value: [YemeklerModel]())
    let context = appDelegate.persistentContainer.viewContext
    
    func favoriKaydet(yemekAdi: String, yemekFiyat: String, yemekResimAdi: String){
        let yemek = YemeklerModel(context: context)
        yemek.yemek_adi = yemekAdi
        yemek.yemek_fiyat = yemekFiyat
        yemek.yemek_resim_adi = yemekResimAdi
        
        appDelegate.saveContext()
    }
    
    func favoriSil(yemek: YemeklerModel){
        context.delete(yemek)
        appDelegate.saveContext()
        favorileriYukle()
    }
    
    func ara(arananKelime: String){
        do {
            let fetchRequest = YemeklerModel.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "yemek_adi CONTAINS[c] %@", arananKelime)
            
            let liste = try context.fetch(fetchRequest)
            favorilerListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func favorileriYukle(){
        do {
            let liste = try context.fetch(YemeklerModel.fetchRequest())
            favorilerListesi.onNext(liste)
        } catch {
            print(error.localizedDescription)
        }
    }
}
