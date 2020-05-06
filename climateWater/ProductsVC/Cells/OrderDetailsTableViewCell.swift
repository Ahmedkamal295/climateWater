//
//  OrderDetailsTableViewCell.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 2/21/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit
import Alamofire
class OrderDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var orderId: UILabel!
    @IBOutlet weak var lblCreateAt: UILabel!
    @IBOutlet weak var lblUpdate: UILabel!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var offerlbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell(orderProducts: OrderProducts) {
        
        orderId.text = "\(orderProducts.products?.id ?? 0)"
        offerlbl.text = "\(orderProducts.products?.offer ?? 0)"
        pricelbl.text = "\(orderProducts.products?.price ?? 0)"
        lblCreateAt.text = orderProducts.products?.created_at ?? "No Date"
       // lblUpdate.text = "\(orderProducts.products?.updated_at)"
        lblUpdate.text = orderProducts.products?.updated_at ?? "No Date"
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
