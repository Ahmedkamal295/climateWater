//
//  CollectionViewCell.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

protocol CollectionViewWater {
    func AddToCartButton(index: Int)
}

import UIKit
import Alamofire

class CollectionViewCell: UICollectionViewCell {
    
    var delegate: CollectionViewWater?
    var index: IndexPath?
    
    @IBOutlet weak var addtocartout: UIButton!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDetails: UILabel!
    @IBOutlet weak var trashImg: UIImageView!
    
    func setProduct(product: WaterProductsMain) {
        labelTitle.text = product.name
        labelDetails.text = "\(product.price)"
        download_image(image_url: product.image,imagedisplayed: imageCell)
    }
    
    @IBAction func addToCartBtn(_ sender: Any) {
        delegate?.AddToCartButton(index: (index?.row)!)
    }
    
    func download_image(image_url:String,imagedisplayed:UIImageView){
        let remoteImageURL = URL(string: "\(image_url)")!
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    imagedisplayed.image = UIImage(data: data)
                } else {
                    return
                }
            }
        }
    }
}
