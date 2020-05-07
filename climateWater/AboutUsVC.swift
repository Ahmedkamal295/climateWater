//
//  AboutUsVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class AboutUsVC: UIViewController {

    @IBOutlet weak var aboutUsView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var txtAboutUs: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        getAbout()
        
        aboutUsView.layer.shadowColor = UIColor.white.cgColor
        aboutUsView.layer.shadowOpacity = 0.2
        aboutUsView.layer.shadowOffset = .zero
        aboutUsView.layer.shadowRadius = 4
        aboutUsView.layer.shouldRasterize = true
        aboutUsView.layer.rasterizationScale = UIScreen.main.scale
        aboutUsView.layer.cornerRadius = 10
        aboutUsView.layer.borderColor = UIColor.white.cgColor
        aboutUsView.layer.borderWidth = 0.2
        
        imageView.layer.cornerRadius = 7.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.borderWidth = 0.2
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func getAbout() {
        txtAboutUs.text = ""
        let getabouturl = "http://climate-app.elsharkawy.azq1.com/api/about-application"
        Alamofire.request(getabouturl).responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                     let aboutdata = arrayOfDic["data"] as! String
                    print("\(arrayOfDic)")
                    self.txtAboutUs.text = "\(aboutdata)"
                    self.txtAboutUs.isEditable = false
            }
        }
    }
}
