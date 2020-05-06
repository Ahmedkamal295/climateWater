//
//  LanguageVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import MOLH

extension UIView {
    @IBInspectable var corner:CGFloat {
        set{
            layer.cornerRadius = newValue
        }
        get{
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var border_width:CGFloat {
        set{
            layer.borderWidth = newValue
        }
        get{
            return layer.borderWidth
        }
    }
    
    @IBInspectable var border_color:UIColor? {
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
        get{
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
    }
}

class LanguageVC: UIViewController {
    
    @IBOutlet weak var btnArabicOutlet: UIButton!
    @IBOutlet weak var btnEnglishOutlet: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        if(AppDelegate.login == true) {
            let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
            let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
            self.present(nextvc,animated: false,completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
         
        btnArabicOutlet.layer.cornerRadius = 10
        btnArabicOutlet.layer.borderColor = UIColor.gray.cgColor
        btnArabicOutlet.layer.borderWidth = 0.2
        
        btnEnglishOutlet.layer.cornerRadius = 10
        btnEnglishOutlet.layer.borderColor = UIColor.gray.cgColor
        btnEnglishOutlet.layer.borderWidth = 0.2
    }
    
    @IBAction func btnArabic(_ sender: Any) {
        MOLH.setLanguageTo("ar")
        MOLH.reset()
    }
    
    @IBAction func btnEnglish(_ sender: Any) {
        MOLH.setLanguageTo("en")
        MOLH.reset()
    }
}
