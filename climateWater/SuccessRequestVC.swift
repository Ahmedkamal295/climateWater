//
//  SuccessRequestVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit

class SuccessRequestVC: UIViewController {

    @IBOutlet weak var successRequestView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        successRequestView.layer.shadowColor = UIColor.black.cgColor
        successRequestView.layer.shadowOpacity = 0.2
        successRequestView.layer.shadowOffset = .zero
        successRequestView.layer.shadowRadius = 4
        successRequestView.layer.shouldRasterize = true
        successRequestView.layer.rasterizationScale = UIScreen.main.scale
        successRequestView.layer.cornerRadius = 7.5
        successRequestView.layer.borderColor = UIColor.gray.cgColor
        successRequestView.layer.borderWidth = 0.2
    }
    
    @IBAction func btnX(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
}
