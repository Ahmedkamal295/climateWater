//
//  HomeVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController {
    
    var Maincategories = [MainCategories]()
    
    @IBOutlet weak var tittleCat1: UILabel!
    @IBOutlet weak var discribCat1: UILabel!
    @IBOutlet weak var imageCat1: UIImageView!
    @IBOutlet weak var tittleCat2: UILabel!
    @IBOutlet weak var discribCat2: UILabel!
    @IBOutlet weak var imageCat2: UIImageView!
    @IBOutlet weak var viewScroll: UIView!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var tissueView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        
        waterView.layer.transform = rotationTransform
        
        tissueView.layer.transform = rotationTransform
        
        view1.layer.transform = rotationTransform
        view2.layer.transform = rotationTransform
        view3.layer.transform = rotationTransform
        view4.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 0.4, animations: { self.view4.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 0.5, animations: { self.view3.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.view2.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.2, animations: { self.view1.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.tissueView.layer.transform = CATransform3DIdentity })
        UIView.animate(withDuration: 1.0, animations: { self.waterView.layer.transform = CATransform3DIdentity })
     }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        getMainCategories()
        
        waterView.layer.shadowColor = UIColor.black.cgColor
        waterView.layer.shadowOpacity = 0.2
        waterView.layer.shadowOffset = .zero
        waterView.layer.shadowRadius = 4
        waterView.layer.shouldRasterize = true
        waterView.layer.rasterizationScale = UIScreen.main.scale
        waterView.layer.cornerRadius = 7.5
        
        tissueView.layer.shadowColor = UIColor.black.cgColor
        tissueView.layer.shadowOpacity = 0.2
        tissueView.layer.shadowOffset = .zero
        tissueView.layer.shadowRadius = 4
        tissueView.layer.shouldRasterize = true
        tissueView.layer.rasterizationScale = UIScreen.main.scale
        tissueView.layer.cornerRadius = 7.5
        
        view1.layer.cornerRadius = 7.5
        view2.layer.cornerRadius = 7.5
        view3.layer.cornerRadius = 7.5
        view4.layer.cornerRadius = 7.5
    }
    
    @IBAction func reminderBuuton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnWater(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "WaterVC") as! WaterVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnTissue(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "TissueVC") as! TissueVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnWholeSaleOrders(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "WholesaleOrdersVC") as! WholesaleOrdersVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnCharityOrders(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "CharityOrderVC") as! CharityOrderVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnContactUs(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnAboutUs(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "AboutUsVC") as! AboutUsVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func btnMyProfile(_ sender: Any) {
        
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
    
    @IBAction func notiButton(_ sender: Any) {
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
    
    func getMainCategories() {
        let getabouturl = "https://climateapp.el-sabat.com/api/categories".localized
        Alamofire.request(getabouturl).responseJSON { response in
            let result = response.result
            print("the response is 1 : \(result)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
               let Categoriesdata = arrayOfDic["data"] as? [Dictionary<String, AnyObject>]
                for aDic1 in Categoriesdata!{
                    
                    if(aDic1["id"]! as! Int == 1){
                        self.tittleCat1.text = aDic1["name"] as? String
                        self.discribCat1.text = aDic1["description"] as? String
                        self.download_image(image_url:aDic1["image"] as! String,imagedisplayed:self.imageCat1)
                    }
                    if(aDic1["id"]! as! Int == 2){
                        self.tittleCat2.text = aDic1["name"] as? String
                        self.discribCat2.text = aDic1["description"] as? String
                        self.download_image(image_url:aDic1["image"] as! String,imagedisplayed:self.imageCat2)
                    }
                }
            }
        }
    }
    
    func download_image(image_url:String,imagedisplayed:UIImageView){
        let remoteImageURL = URL(string: "\(image_url)")!
        Alamofire.request(remoteImageURL).responseData { (response) in
            if response.error == nil {
                print(response.result)
                if let data = response.data {
                    imagedisplayed.image = UIImage(data: data)
                } else {
                    return
                }
            }
        }
    }
}
