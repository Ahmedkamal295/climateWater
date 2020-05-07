//
//  MainCategories.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import Foundation

class MainCategories {
    var id: Int
    var name: String
    var description: String
    var image: String
    
    init(id: Int, name: String, description: String, image: String) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
    }
}
