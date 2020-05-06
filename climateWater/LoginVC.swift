//
//  LoginVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnSignInOutlet: UIButton!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        txtPhoneNumber.delegate = self
        txtPassword.delegate = self
        
        phoneNumberView.layer.cornerRadius = 7.5
        phoneNumberView.layer.borderColor = UIColor.gray.cgColor
        phoneNumberView.layer.borderWidth = 0.2
        
        passwordView.layer.cornerRadius = 7.5
        passwordView.layer.borderColor = UIColor.gray.cgColor
        passwordView.layer.borderWidth = 0.2
        
        btnSignInOutlet.layer.cornerRadius = 7.5
        btnSignInOutlet.layer.borderColor = UIColor.gray.cgColor
        btnSignInOutlet.layer.borderWidth = 0.2
        
        btnSignUpOutlet.layer.cornerRadius = 7.5
        btnSignUpOutlet.layer.borderColor = UIColor.gray.cgColor
        btnSignUpOutlet.layer.borderWidth = 0.2
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
         if ((txtPhoneNumber.text?.isEmpty)! || (txtPassword.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "please enter all of your information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        } else {
            self.getSignInData()
        }
    }
    
      @IBAction func btnSignUp(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.present(nextvc,animated: true,completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func getSignInData() {
        let mobile = txtPhoneNumber.text!
        let password = txtPassword.text!
        let loginurl = "https://climateapp.el-sabat.com/api/auth/login"
        let parameters = [
            "mobile" : mobile,
            "password" : password
        ]
        Alamofire.request(loginurl, method: .post, parameters: parameters)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if ("\(result)" != "SUCCESS") {
                    let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    let userdata = arrayOfDic["data"] as? Dictionary<String, AnyObject>
                    let status = arrayOfDic["status"] as? String
                    if status == "success" {
                    let token = userdata?["token"] as! String
                    let user1 = userdata?["user"] as? Dictionary<String, AnyObject>
                    let mobile = user1?["mobile"] as! String
                    let id = user1?["id"] as! Int
                    let name = user1?["name"] as! String
                    
                    UserDefaults.standard.set(token, forKey: "token")
                    UserDefaults.standard.synchronize()
                    
                    UserDefaults.standard.set(name, forKey: "name")
                    UserDefaults.standard.synchronize()
                    
                    UserDefaults.standard.set(mobile, forKey: "mobile")
                    UserDefaults.standard.synchronize()
                    
                    
                    AppDelegate.global_user = User(id: id, name: name, mobile: mobile, token: token)
                    AppDelegate.login = true
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
                    self.present(nextViewController, animated:true, completion:nil)
                    } else {
                        let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                    }
                }
            }
        }
    }
}
