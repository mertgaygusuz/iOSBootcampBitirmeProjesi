//
//  FoodRepository.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 26.10.2023.
//

import Foundation
import Alamofire
import RxSwift
import CoreData

class FoodRepository {
    var yemeklerListesi = BehaviorSubject<[Yemekler]>(value: [Yemekler]())
    
    func kaydet(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int) {
        let params: Parameters = ["yemek_adi":yemek_adi,"yemek_resim_adi":yemek_resim_adi,"yemek_fiyat":yemek_fiyat,"yemek_siparis_adet":yemek_siparis_adet,"kullanici_adi":"mertgygsz"]
        let urlString = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        AF.request(urlString, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CrudCevap.self, from: data)
                    print("Başarı: \(cevap.success!), Mesaj: \(cevap.message!)")
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekleriYukle() {
        let urlString = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        AF.request(urlString, method: .get).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let liste = cevap.yemekler {
                        self.yemeklerListesi.onNext(liste)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
