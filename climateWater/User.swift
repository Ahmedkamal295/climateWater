//
//  User.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import Foundation

class User {
    var id: Int
    var name: String
    var mobile: String
    var token: String
    
    init(id: Int, name: String, mobile: String, token: String) {
        self.id = id
        self.name = name
        self.mobile = mobile
        self.token = token
    }
}
