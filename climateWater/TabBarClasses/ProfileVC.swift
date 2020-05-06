//
//  ProfileVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire
import MOLH

class ProfileVC: UIViewController {
    
    @IBOutlet weak var view1: CustomUIView!
    @IBOutlet weak var view2: CustomUIView!
    @IBOutlet weak var view3: CustomUIView!
    @IBOutlet weak var view4: CustomUIView!
    @IBOutlet weak var view5: CustomUIView!
    @IBOutlet weak var logOutBtn: UIButton!
    
    @IBOutlet weak var btnfaceBook: UIButton!
    @IBOutlet weak var btnYoutube: UIButton!
    @IBOutlet weak var btnWhats: UIButton!
    @IBOutlet weak var btnInsta: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        logOutBtn.layer.transform = rotationTransform
        view1.layer.transform = rotationTransform
        view2.layer.transform = rotationTransform
        view3.layer.transform = rotationTransform
        view4.layer.transform = rotationTransform
        view5.layer.transform = rotationTransform
        
        btnfaceBook.layer.transform = rotationTransform
        btnYoutube.layer.transform = rotationTransform
        btnWhats.layer.transform = rotationTransform
        btnInsta.layer.transform = rotationTransform
        
        
        UIView.animate(withDuration: 1.0, animations: { self.view5.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 0.5, animations: { self.view4.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 0.4, animations: { self.view3.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 0.3, animations: { self.view2.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 0.2, animations: { self.view1.layer.transform = CATransform3DIdentity })
        
        UIView.animate(withDuration: 1.0, animations: { self.btnfaceBook.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.btnYoutube.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.btnWhats.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.btnInsta.layer.transform = CATransform3DIdentity })
        
        UIView.animate(withDuration: 1.2, animations: { self.logOutBtn.layer.transform = CATransform3DIdentity })
       
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
      
    }
    
    @IBAction func trackYouOrdersButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
               let nextvc = storyBoard.instantiateViewController(withIdentifier: "TrackYourOrdersVC") as! TrackYourOrdersVC
               self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func editeMyProfileButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "MydetailsVC") as! MydetailsVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func reminderBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC
        self.present(nextvc,animated: false,completion: nil)
    }
   
    @IBAction func btnShare(_ sender: Any) {
        let text = "Hey! Lets Download climateWater \(kAPPURL)"
        let objectsToShare: [Any] = [text]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.setValue("Lets Download climateWater", forKey: "subject")
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func MyaddressesButton(_ sender: Any) {
        
        let text = "Hey! Lets Download climateWater \(kAPPURL)"
        let objectsToShare: [Any] = [text]
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.setValue("Lets Download climateWater", forKey: "subject")
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func changeLanguageBtn(_ sender: Any) {
        if MOLHLanguage.isArabic() {
            MOLH.setLanguageTo("en")
            MOLH.reset()
        } else {
            MOLH.setLanguageTo("ar")
            MOLH.reset()
        }
    }
    
    @IBAction func backBuuton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func logOutbutton(_ sender: Any) {
        UserDefaults.standard.setValue(nil, forKey: "token")
        UserDefaults.standard.synchronize()
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func homeBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    @IBAction func ReminderBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        self.present(nextViewController, animated:false, completion:nil)
    }
    @IBAction func notificationBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "notificationVC") as! notificationVC
        self.present(nextViewController, animated:false, completion:nil)
    }
}
