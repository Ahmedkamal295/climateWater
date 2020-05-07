//
//  ContinueShoppingVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit

class ContinueShoppingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    @IBAction func continueBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:false, completion:nil)
    }
}
