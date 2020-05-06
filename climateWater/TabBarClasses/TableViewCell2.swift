//
//  TableViewCell2.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit

protocol TableViewCellProtocol {
    func deleteView(indx: Int)
}

class TableViewCell2: UITableViewCell {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
 
    override func awakeFromNib() {
            super.awakeFromNib()
           
            deleteBtn.layer.cornerRadius = deleteBtn.frame.size.width / 2
            deleteBtn.clipsToBounds  = true
        }

        var delegate: TableViewCellProtocol?
        var index: IndexPath?
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
    
        @IBAction func btnDelete(_ sender: Any) {
            delegate?.deleteView(indx: (index?.row)!)
    }
}
