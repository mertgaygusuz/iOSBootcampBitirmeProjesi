//
//  CartRepository.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 12.11.2023.
//

import Foundation
import Alamofire
import RxSwift

class CartRepository {
    var sepetListesi = BehaviorSubject<[SepettekiYemekler]>(value: [SepettekiYemekler]())
    
    func sepetiSil(yemek_id: Int, kullanici_adi: String){
        let params: Parameters = ["sepet_yemek_id":yemek_id,"kullanici_adi":kullanici_adi]
        let urlString = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        AF.request(urlString, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(CrudCevap.self, from: data)
                    print("Başarı: \(cevap.success!), Mesaj: \(cevap.message!)")
                    self.sepettekiYemekleriYukle()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func sepettekiYemekleriYukle() {
        let params: Parameters = ["kullanici_adi":"mertgygsz"]
        let urlString = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        AF.request(urlString, method: .post, parameters: params).response { response in
            if let data = response.data {
                do {
                    let cevap = try JSONDecoder().decode(SepettekiYemeklerCevap.self, from: data)
                    if let liste = cevap.sepet_yemekler {
                        self.sepetListesi.onNext(liste)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
