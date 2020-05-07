//
//  SignUpVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class SignUpVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var phoneNumberView: UIView!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var btnSignUpOutlet: UIButton!
    @IBOutlet weak var btnSignInOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        txtUserName.delegate = self
        txtPhoneNumber.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        
        userNameView.layer.cornerRadius = 7.5
        userNameView.layer.borderColor = UIColor.gray.cgColor
        userNameView.layer.borderWidth = 0.2
        
        phoneNumberView.layer.cornerRadius = 7.5
        phoneNumberView.layer.borderColor = UIColor.gray.cgColor
        phoneNumberView.layer.borderWidth = 0.2
        
        passwordView.layer.cornerRadius = 7.5
        passwordView.layer.borderColor = UIColor.gray.cgColor
        passwordView.layer.borderWidth = 0.2
        
        confirmPasswordView.layer.cornerRadius = 7.5
        confirmPasswordView.layer.borderColor = UIColor.gray.cgColor
        confirmPasswordView.layer.borderWidth = 0.2
        
        btnSignUpOutlet.layer.cornerRadius = 7.5
        btnSignUpOutlet.layer.borderColor = UIColor.gray.cgColor
        btnSignUpOutlet.layer.borderWidth = 0.2
        
        btnSignInOutlet.layer.cornerRadius = 7.5
        btnSignInOutlet.layer.borderColor = UIColor.gray.cgColor
        btnSignInOutlet.layer.borderWidth = 0.2
    }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func btnTermsOfUse(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "TermsVC") as! TermsVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        if ((txtUserName.text?.isEmpty)! || (txtPhoneNumber.text?.isEmpty)! || (txtPassword.text?.isEmpty)! || (txtConfirmPassword.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "Please enter all your information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else if (txtPassword.text != txtConfirmPassword.text) {
            let alert = UIAlertController(title: "Error".localized, message: "Passwords not matches".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Attention".localized, message: "By click on sign up you agree to the privacy".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Accept".localized, style: .cancel, handler: {
                action in
                self.getSignUpData()
            })
            let cancelAction = UIAlertAction(title: "Cancel".localized, style: .default, handler: nil)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnSignIn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    func getSignUpData() {

        let username = txtUserName.text!
        let mobile = txtPhoneNumber.text!
        let password = txtPassword.text!
        let passwordConfirm = txtConfirmPassword.text!
        let signupurl = "https://climateapp.el-sabat.com/api/auth/register"
        let parameters = [
            "name" : username,
            "mobile" : mobile,
            "password" : password,
            "password_confirmation" : passwordConfirm,
            "email" : " "
        ]
        Alamofire.request(signupurl, method: .post, parameters: parameters)
            .responseJSON { response in
                let result = response.result
                print("the response is 1 : \(result)")
                if ("\(result)" == "FAILURE") {
                    let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    let userdata = arrayOfDic["data"] as? Dictionary<String, AnyObject>
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
                }
            }
        }
    }
}
