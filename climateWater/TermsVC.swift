//
//  TermsVC.swift
//  climateWater
//
//  Created by Ahmed on 1/5/20.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class TermsVC: UIViewController {

    @IBOutlet weak var txtTerms: UITextView!
    @IBOutlet weak var termsView: UIView!
    @IBOutlet weak var imageview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        getTerms()
        
        termsView.layer.shadowColor = UIColor.white.cgColor
        termsView.layer.shadowOpacity = 0.2
        termsView.layer.shadowOffset = .zero
        termsView.layer.shadowRadius = 4
        termsView.layer.shouldRasterize = true
        termsView.layer.rasterizationScale = UIScreen.main.scale
        termsView.layer.cornerRadius = 10
        termsView.layer.borderColor = UIColor.white.cgColor
        termsView.layer.borderWidth = 0.2
        
        imageview.layer.cornerRadius = 7.5
        imageview.layer.borderColor = UIColor.gray.cgColor
        imageview.layer.borderWidth = 0.2
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func getTerms() {
        txtTerms.text = ""
        let getaTerms = "http://climate-app.elsharkawy.azq1.com/api/terms-condition"
        Alamofire.request(getaTerms).responseJSON { response in
            let result = response.result
            print("the response is 1 : \(result)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                let termsData = arrayOfDic["data"] as! String
                print("\(arrayOfDic)")
                self.txtTerms.text = "\(termsData)"
                self.txtTerms.isEditable = false
            }
        }
    }
}
