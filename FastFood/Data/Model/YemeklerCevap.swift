//
//  FoodResponse.swift
//  FastFood
//
//  Created by Mert Gaygusuz on 28.10.2023.
//

import Foundation

class YemeklerCevap: Codable {
    var yemekler: [Yemekler]?
    var success: Int?
}
