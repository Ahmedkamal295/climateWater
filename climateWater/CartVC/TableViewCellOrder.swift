//
//  TableViewCellOrder.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class TableViewCellOrder: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var reedylbl: UILabel!
    @IBOutlet weak var outlbl: UILabel!
    @IBOutlet weak var deleverdlbl: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        one.layer.cornerRadius = one.frame.size.width / 2
        one.clipsToBounds  = true
        
        two.layer.cornerRadius = two.frame.size.width / 2
        two.clipsToBounds  = true
        
        three.layer.cornerRadius = three.frame.size.width / 2
        three.clipsToBounds  = true
    }
    func configureCell(singleOrderStatus: OrderTrackingModelData) {
        if singleOrderStatus.status == 1 {
            
     
            one.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            reedylbl.textColor = UIColor.black
            
            
        }else if singleOrderStatus.status == 2 {
            
            one.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            two.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
           reedylbl.textColor = UIColor.black
           outlbl.textColor = UIColor.black
            
            
        }else if singleOrderStatus.status == 3 {
            
            one.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            two.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            three.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            reedylbl.textColor = UIColor.black
            outlbl.textColor = UIColor.black
            deleverdlbl.textColor = UIColor.black
                      
            
        }
        
        lbl1.text = singleOrderStatus.address?.address_title ?? "No Address"
        lbl2.text = "\(singleOrderStatus.final_price ?? 0)"
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
