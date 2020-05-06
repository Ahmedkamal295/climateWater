//
//  WaterProductsMain.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import Foundation

class WaterProductsMain{
    var id: Int
    var category_id: Int
    var name: String
    var description: String
    var image: String
    var price: Int
    var offer: Int
    var has_offer: Bool
    
    init(id: Int,category_id: Int, name: String, description: String, image: String,price: Int,offer: Int,has_offer: Bool) {
        self.id = id
        self.category_id = category_id
        self.name = name
        self.description = description
        self.image = image
        self.price = price
        self.offer = offer
        self.has_offer = has_offer
    }
}
