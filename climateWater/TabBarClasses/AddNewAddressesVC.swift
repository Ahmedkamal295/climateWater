//
//  AddNewAddressesVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class AddNewAddressesVC: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txt: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var neighnorhoodText: UITextField!
    @IBOutlet weak var namNumberText: UITextField!
    @IBOutlet weak var buldingNameText: UITextField!
    @IBOutlet weak var floorNumberText: UITextField!
    @IBOutlet weak var apartmentNumberText: UITextField!
    @IBOutlet weak var txtYourMessage: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        Car.model = "MG6"
       
        txtYourMessage.text = "Your Massage"
        txtYourMessage.textColor = UIColor.gray
        txtYourMessage.font = UIFont(name: "verdana", size: 20.0)
        txtYourMessage.returnKeyType = .done
        txtYourMessage.delegate = self
    }

    @IBAction func go(){
        if ((txt.text?.isEmpty)! || (cityText.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            userInfo.addrees = txt.text
            userInfo.city = cityText.text
            userInfo.neigburhood = neighnorhoodText.text
            userInfo.st_name = namNumberText.text
            userInfo.bulding_name = buldingNameText.text
            userInfo.floor_nmber = floorNumberText.text
            userInfo.aparment_num = apartmentNumberText.text
            dismiss(animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        
    }
    
   
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Your Massage" {
            textView.text = ""
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "verdana", size: 18.0)
        }
    }
                
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
                
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Your Massage"
            textView.textColor = UIColor.gray
            textView.font = UIFont(name: "verdana", size: 20.0)
        }
    }
      
    func getSignInData() {
        let txtaddress = txt.text!
        let cityTextaddress = cityText.text!
        let neighnorhoodTextaddress = neighnorhoodText.text!
        let namNumberTextaddress = namNumberText.text!
        let buldingNameTextaddress = buldingNameText.text!
        let floorNumberTextaddress = floorNumberText.text!
        let apartmentNumberTextaddress = apartmentNumberText.text!
        let txtYourMessageaddress = txtYourMessage.text!
        let createaddressurl = "https://climateapp.el-sabat.com/api/address"
        let parameters = [
            "address_title" : txtaddress,
            "city" : cityTextaddress,
            "neighborhood" : neighnorhoodTextaddress,
            "street_no" : buldingNameTextaddress,
            "building_no" : namNumberTextaddress,
            "flat_no" : floorNumberTextaddress,
            "apartment_no" : apartmentNumberTextaddress,
            "notes" : txtYourMessageaddress,
        ]
        
        guard let token = UserDefaults.standard.object(forKey: "token") else {return}
        let headers = ["Authorization": "Bearer \(token)"]
        Alamofire.request(createaddressurl, method: .post,parameters: parameters,headers: headers)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                   print("\(arrayOfDic)")
                    let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
                    let nextvc = storyBoard.instantiateViewController(withIdentifier: "DeatailsVC") as! DeatailsVC
                    self.present(nextvc, animated: true) {
                        DeatailsVC.data = "jijijsiai" 
                }
            }
        }
    }
}
