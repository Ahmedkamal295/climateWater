//
//  DeatailsVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire

class DeatailsVC: UIViewController {

    var totalPrice = ""
    var src:AddNewAddressesVC?
    static var data:String = ""
    var isActive:Bool = false
    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var totalPrice2: UILabel!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var btnSelect1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DeatailsVC.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DeatailsVC.viewTapped(gesrureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        inputTextField.inputView = datePicker
        totalPrice2.text = totalPrice
    }
    
    @objc func viewTapped(gesrureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
     @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/hh"
        inputTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lbl.text = "\(userInfo.addrees ?? ""),\(userInfo.city ?? ""),\(userInfo.neigburhood ?? ""),\(userInfo.st_name ?? ""),\(userInfo.bulding_name ?? ""),\(userInfo.floor_nmber ?? ""),\(userInfo.aparment_num ?? "")"
               
        UserDefaults.standard.setValue(lbl.text!, forKey: "email")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func btnContinueShopping(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnSelect1(_ sender: UIButton) {
        btnSelect1.isSelected = true
    }
    
    @IBAction func addNewAddressBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "AddNewAddressesVC") as! AddNewAddressesVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func Confirmbtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ContinueShoppingVC") as! ContinueShoppingVC
        self.present(nextvc,animated: false,completion: nil)
    }
   
    
    
    func sendOrders() {
        let TimeinputTextField = inputTextField.text!
        let Addresslbl = lbl.text!
        let lbltotalPrice2 = totalPrice2.text!
        let sendurl = "http://climate-app.elsharkawy.azq1.com/api/sale-orders"
        let parameters = [
            "name" : TimeinputTextField,
            "phone" : Addresslbl,
            "subject" : lbltotalPrice2,
          
        ]
        Alamofire.request(sendurl, method: .post,parameters: parameters)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SuccessRequestVC") as! SuccessRequestVC
                    self.present(nextViewController, animated:true, completion:nil)
                }
        }
    }
}


