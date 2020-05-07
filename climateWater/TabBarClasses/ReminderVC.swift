//
//  ReminderVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ReminderVC: UIViewController {
    
    @IBOutlet weak var viewP: UIView!
    @IBOutlet weak var progressView: MBCircularProgressBarView!
    @IBOutlet weak var btnDrinkWaterOutlet: UIButton!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    
    var isAction:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        self.progressView.value = 0
        
        progressView.layer.cornerRadius = progressView.frame.size.width / 2
        progressView.clipsToBounds  = true
        
        viewP.layer.cornerRadius = viewP.frame.size.width / 2
        viewP.clipsToBounds  = true
        
        btnDrinkWaterOutlet.layer.cornerRadius = 7.5
        btnDrinkWaterOutlet.layer.borderColor = UIColor.gray.cgColor
        btnDrinkWaterOutlet.layer.borderWidth = 0.2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 2.0) {
            self.progressView.value = 60
        }
    }
    
    @IBAction func btn4(_ sender: UIButton) {
        sender.pulsate()
            btn3.isSelected = false
            btn2.isSelected = false
            btn1.isSelected = false
            btn4.isSelected = true
            btn4.isSelected = true
    }
    
    @IBAction func btn3(_ sender: UIButton) {
       sender.pulsate()
            btn1.isSelected = false
            btn2.isSelected = false
            btn4.isSelected = false
            btn3.isSelected = true
            btn3.isSelected = true
    }
    
    @IBAction func btn2(_ sender: UIButton) {
        sender.pulsate()
            btn1.isSelected = false
            btn3.isSelected = false
            btn4.isSelected = false
            btn2.isSelected = true
            btn2.isSelected = true
    }
    
    @IBAction func btn1(_ sender: UIButton) {
        sender.pulsate()
             btn2.isSelected = false
             btn3.isSelected = false
             btn4.isSelected = false
             btn1.isSelected = true
    }
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnSettings(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnDrinkWater(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:false, completion:nil)
    }
   
    @IBAction func profileBtn(_ sender: Any) {
              guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
                let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
                let nextvc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                self.present(nextvc,animated: false,completion: nil)
                                
                return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func notificationBtn(_ sender: Any) {
               guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
                   let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                   alert.addAction(okAction)
                   self.present(alert, animated: true, completion: nil)
                   return
             }
        
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "notificationVC") as! notificationVC
        self.present(nextvc,animated: false,completion: nil)
    }
}
