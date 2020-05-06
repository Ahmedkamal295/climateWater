//
//  OrderDetailsVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 2/21/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
class OrderDetailsVC: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var lblReedy: UILabel!
    @IBOutlet weak var lblOut: UILabel!
    @IBOutlet weak var lblDeleverd: UILabel!
    @IBOutlet weak var productsTableView: UITableView!
    
     var productDet:ProductsModelData!
    var orderProducts: [OrderProducts]?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         
               one.layer.cornerRadius = one.frame.size.width / 2
               one.clipsToBounds  = true
               
               two.layer.cornerRadius = two.frame.size.width / 2
               two.clipsToBounds  = true
               
               three.layer.cornerRadius = three.frame.size.width / 2
               three.clipsToBounds  = true
             // download_image(image_url:productDet.image,imagedisplayed:img)

//              lblName.text = "\(productDet.name ?? "")"
//              lblPrice.text = "\(productDet.price ?? 0)"

        
        productsTableView.dataSource = self
        productsTableView.delegate = self
    }
 
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
extension OrderDetailsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
extension OrderDetailsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  orderProducts?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsTableViewCell", for: indexPath) as? OrderDetailsTableViewCell else {
            return UITableViewCell()
        }
        if let orderProduct = orderProducts?[indexPath.row] {
           cell.configureCell(orderProducts: orderProduct)
        }
        return cell
    }
}


