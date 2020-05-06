//
//  WholesaleOrdersVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire

class WholesaleOrdersVC: UIViewController, UITextViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var wholeSaleOrdersView: UIView!
    @IBOutlet weak var fullNameView: UIView!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var yourEmailView: UIView!
    @IBOutlet weak var txtYourEmail: UITextField!
    @IBOutlet weak var subjectView: UIView!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var yourMessageView: UIView!
    @IBOutlet weak var txtYourMessage: UITextView!
    @IBOutlet weak var btnSendOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
       
        
        
        wholeSaleOrdersView.layer.shadowColor = UIColor.white.cgColor
        wholeSaleOrdersView.layer.shadowOpacity = 0.2
        wholeSaleOrdersView.layer.shadowOffset = .zero
        wholeSaleOrdersView.layer.shadowRadius = 4
        wholeSaleOrdersView.layer.shouldRasterize = true
        wholeSaleOrdersView.layer.rasterizationScale = UIScreen.main.scale
        wholeSaleOrdersView.layer.cornerRadius = 10
        wholeSaleOrdersView.layer.borderColor = UIColor.white.cgColor
        wholeSaleOrdersView.layer.borderWidth = 0.2
        
        fullNameView.layer.cornerRadius = 7.5
        fullNameView.layer.borderColor = UIColor.gray.cgColor
        fullNameView.layer.borderWidth = 0.2
        
        phoneNumberView.layer.cornerRadius = 7.5
        phoneNumberView.layer.borderColor = UIColor.gray.cgColor
        phoneNumberView.layer.borderWidth = 0.2
        
        yourEmailView.layer.cornerRadius = 7.5
        yourEmailView.layer.borderColor = UIColor.gray.cgColor
        yourEmailView.layer.borderWidth = 0.2
        
        subjectView.layer.cornerRadius = 7.5
        subjectView.layer.borderColor = UIColor.gray.cgColor
        subjectView.layer.borderWidth = 0.2
        
        txtYourMessage.text = "Your Massage"
        txtYourMessage.textColor = UIColor.gray
        txtYourMessage.font = UIFont(name: "verdana", size: 20.0)
        txtYourMessage.returnKeyType = .done
        txtYourMessage.delegate = self
        
        btnSendOutlet.layer.cornerRadius = 7.5
        btnSendOutlet.layer.borderColor = UIColor.gray.cgColor
        btnSendOutlet.layer.borderWidth = 0.2
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnSend(_ sender: Any) {
        
        if ((txtFullName.text?.isEmpty)! || (txtPhoneNumber.text?.isEmpty)! || (txtYourEmail.text?.isEmpty)! || (txtSubject.text?.isEmpty)! || (txtYourMessage.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "Please enter all your data".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
        } else if ((txtFullName.text!.count < 5) || (txtPhoneNumber.text!.count < 9) || (txtYourEmail.text!.count < 5) || (txtSubject.text!.count < 5) || (txtYourMessage.text!.count < 6)) {
            let alert = UIAlertController(title: "Error".localized, message: "Your data is not complete".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            send()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
    
    func send() {
        let txtFullNameend = txtFullName.text!
        let txtPhoneNumberend = txtPhoneNumber.text!
        let txtYourEmailend = txtYourEmail.text!
        let txtSubjectend = txtSubject.text!
        let sendurl = "http://climate-app.elsharkawy.azq1.com/api/sale-orders"
        let parameters = [
            "name" : txtFullNameend,
            "phone" : txtPhoneNumberend,
            "subject" : txtYourEmailend,
            "message" : txtSubjectend,
            "asasasas" : " "
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
