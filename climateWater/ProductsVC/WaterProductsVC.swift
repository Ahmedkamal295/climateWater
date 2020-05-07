//
//  WaterProductsVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class WaterProductsVC: UIViewController {
        
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var waterView: UIView!
    @IBOutlet weak var imgWater: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var btnPlusOutlet: UIButton!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var btnMinuesOutlet: UIButton!
    @IBOutlet weak var btnAddToCartOutlet: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    
     var productInfo:WaterProductsMain!
       var selectProduct = 0
       var selectCategory = 1 {
           didSet {
               lblTotal.text = "\( selectCategory * productInfo.price)"
           }
       }
    
   
    var image = UIImage()
    var name = ""
    var name2 = ""
    var name3 = ""
    var name4 = ""
    var pro_id = ""
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//        
//        let rotationAngleRadians = 90.0 * CGFloat(Double.pi/180.0)
//        let rotationTransform = CATransform3DMakeRotation(rotationAngleRadians, 0, 0, 1)
//        imgWater.layer.transform = rotationTransform
//        UIView.animate(withDuration: 3.0, animations: { self.imgWater.layer.transform = CATransform3DIdentity })
//    }
    
       override func viewDidLoad() {
           super.viewDidLoad()
        
      
        
        print("5555555 : \(productInfo.price)")
        
        download_image(image_url:productInfo.image,imagedisplayed:imgWater)
        
        lbl1.text = "\(productInfo.name)"
        lbl2.text = "\(productInfo.description)"
        lblTotal.text = "\(productInfo.price)"
        lbl3.text = "\(productInfo.price)"
        
        view2.layer.shadowColor = UIColor.white.cgColor
        view2.layer.shadowOpacity = 1.0
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 4
        view2.layer.shouldRasterize = true
        view2.layer.rasterizationScale = UIScreen.main.scale
        view2.layer.cornerRadius = 10
        view2.layer.borderColor = UIColor.gray.cgColor
        view2.layer.borderWidth = 0.1
        
        btnPlusOutlet.layer.cornerRadius = btnPlusOutlet.frame.size.width / 2
        btnPlusOutlet.clipsToBounds  = true
        
        btnMinuesOutlet.layer.cornerRadius = btnMinuesOutlet.frame.size.width / 2
        btnMinuesOutlet.clipsToBounds  = true
        
        lblNumber.layer.cornerRadius = lblNumber.frame.size.width / 2
        lblNumber.clipsToBounds  = true
    }
    
    @IBAction func btnCart(_ sender: Any) {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "CartViewC") as! CartViewC
        self.present(nextvc,animated: false,completion: nil)
        
    }
    
    @IBAction func btnPlus(_ sender: Any) {
         selectCategory += 1
             lblNumber.text = "\(selectCategory)"
             
             print("hello")
         }
    
    @IBAction func btnMinues(_ sender: Any) {
          if selectCategory > 1{
                 selectCategory = selectCategory - 1
                 lblNumber.text = "\(selectCategory)"
                
             } else {
                 print("You Cant")
             }
         }
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    @IBAction func btnAddToCart(_ sender: UIButton) {
         AddtoCart()
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


extension WaterProductsVC {
    
    func AddtoCart() {
        var addcarturl = "https://climateapp.el-sabat.com/api/cart"
        print(lblNumber.text)


        

        let parameters = [
            "product_id" : pro_id,
            "quantity" : lblNumber.text ?? "0"
            ] as [String : Any]
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let headers = ["Authorization": "Bearer \(token)"]
                  Alamofire.request(addcarturl, method: .post, parameters: parameters ,headers: headers)
                      .responseJSON { response in
                          let result = response.result
                          print("the response is 1 : \(result)")
                          if ("\(result)" != "SUCCESS") {
                              let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
                              let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                              alert.addAction(okAction)
                              self.present(alert, animated: true, completion: nil)
                          } else {
                            print(response.value)
                            let alert = UIAlertController(title: "Success".localized, message: "Send Successfully".localized, preferredStyle: .alert)
                            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                            alert.addAction(okAction)
                            self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
