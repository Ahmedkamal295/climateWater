//
//  TableViewCell.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

protocol TableViewProtocol {
    func deleteData(indx: Int)
}

class TableViewCell: UITableViewCell {
    
    var selectCategory = 1
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var deletebtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        deletebtn.layer.cornerRadius = deletebtn.frame.size.width / 2
        deletebtn.clipsToBounds  = true
    }

    var delegate: TableViewProtocol?
    var index: IndexPath?
    
    @IBAction func deletebtn(_ sender: Any) {
        delegate?.deleteData(indx: (index?.row)!)
    }
}
