//
//  APIService.swift
//  climateWater
//
//  Created by Ahmed on 2/21/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    static let instance = APIService() // singletone
    
    func getOrderStatus(url: String, headers: HTTPHeaders,method: HTTPMethod, completionHandler: @escaping(OrderTrackingModel?, Error?)->()) {
        
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                guard let data = response.data else { return }
                do {
                    let orderStatusModel = try JSONDecoder().decode(OrderTrackingModel.self, from: data)
                    completionHandler(orderStatusModel, nil)
                } catch let jsonError {
                    print(jsonError)
                }
                
            case .failure(let error):
                // internet connection error
                completionHandler(nil, error)
            }
        }
    }
}
