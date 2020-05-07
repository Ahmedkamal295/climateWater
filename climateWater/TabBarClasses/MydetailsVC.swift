//
//  MydetailsVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class MydetailsVC: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        txtFullName.text = UserDefaults.standard.object(forKey: "name") as? String
        txtPhoneNumber.text = UserDefaults.standard.object(forKey: "mobile") as? String
        txtEmail.text = ""
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if ((txtFullName.text?.isEmpty)! || (txtPhoneNumber.text?.isEmpty)! || (txtEmail.text?.isEmpty)! || (txtCurrentPassword.text?.isEmpty)! || (txtNewPassword.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "please enter all of your information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        } else if (txtCurrentPassword.text == txtNewPassword.text) {
            let alert = UIAlertController(title: "Error".localized, message: "please enter your new password".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        } else {
            updateuserdata()
        }
    }
    
    func updateuserdata() {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
                let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            return
        }
        
        let headers = ["Authorization": "Bearer \(token)"]
        let txtFullNameend = txtFullName.text!
        let txtPhoneNumberend = txtPhoneNumber.text!
        let txtEmailend = txtEmail.text!
        let txtCurrentPasswordend = txtCurrentPassword.text!
        let txtNewPasswordend = txtNewPassword.text!
        let updateuserurl = "https://climateapp.el-sabat.com/api/user/update"
        let parameters = [
            "name" : txtFullNameend,
            "mobile" : txtPhoneNumberend,
            "old_password" : txtCurrentPasswordend,
            "password" : txtNewPasswordend,
            "email" : txtEmailend
        ]
        
        if(txtFullName.text?.isEmpty == false && txtPhoneNumber.text?.isEmpty == false && txtEmail.text?.isEmpty == false && txtCurrentPassword.text?.isEmpty == false && txtNewPassword.text?.isEmpty == false){
            let parameters = [
                "name" : txtFullNameend,
                "mobile" : txtPhoneNumberend,
                "old_password" : txtCurrentPasswordend,
                "password" : txtNewPasswordend,
                "email" : txtEmailend
            ]
            print("hey : 1")
        }
        
        if(txtEmail.text?.isEmpty == true && txtCurrentPassword.text?.isEmpty == true && txtNewPassword.text?.isEmpty == true){
            var parameters = [
                "name" : txtFullNameend,
                "mobile" : txtPhoneNumberend,
            ]
            print("hey : 2")
        }

        if(txtEmail.text?.isEmpty == false && txtCurrentPassword.text?.isEmpty == true && txtNewPassword.text?.isEmpty == true){
            var parameters = [
                "name" : txtFullNameend,
                "mobile" : txtPhoneNumberend,
                "email" : txtEmailend
            ]
            print("hey : 3")
        }

        if(txtEmail.text?.isEmpty == true && txtCurrentPassword.text?.isEmpty == false && txtNewPassword.text?.isEmpty == false){
            var parameters = [
                "name" : txtFullNameend,
                "mobile" : txtPhoneNumberend,
                "old_password" : txtCurrentPasswordend,
                "password" : txtNewPasswordend,
                "email" : ""
            ]
            print("hey : 4")
        }
        
        Alamofire.request(updateuserurl, method: .post, parameters: parameters,headers: headers)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    AppDelegate.global_user = User(id: AppDelegate.global_user.id, name: txtFullNameend, mobile: txtPhoneNumberend, token: AppDelegate.global_user.token)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.present(nextViewController, animated:true, completion:nil)
            }
        }
    }
}
