//
//  CartViewC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class CartViewC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var cartArray = [cartmodel]()
    var totalpriceArray = [Int]()
    var total = 0
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var processedcheckout: UIButton!
    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        CartViewC()
        
        tableView.tableFooterView = UIView()
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        cell.lbl.text = cartArray[indexPath.row].name
        cell.lbl2.text = ("\(cartArray[indexPath.row].price!)")
        download_image(image_url: cartArray[indexPath.row].image!, imagedisplayed: cell.img)
        cell.totalPrice.text = "\(self.totalpriceArray[indexPath.row])"
        cell.index = indexPath
        cell.delegate = self
        return cell
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
   
    @IBAction func back(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func processedCheckout(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "DeatailsVC") as! DeatailsVC
        nextvc.totalPrice = "\(total)"
        self.present(nextvc,animated: false,completion: nil)
        
    }
}

extension CartViewC {
    
    func CartViewC() {
                         
        var addcarturl = "https://climateapp.el-sabat.com/api/cart".localized
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let headers = ["Authorization": "Bearer \(token)"]
        Alamofire.request(addcarturl, method: .get, parameters: nil ,headers: headers)
                         .responseJSON { response in
                             let result = response.result
                             print("the response is 1 : \(result)")
                             if ("\(result)" != "SUCCESS") {
                                 let alert = UIAlertController(title: "Error".localized, message: "Please enter all of your correct information".localized, preferredStyle: .alert)
                                 let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
                                 alert.addAction(okAction)
                                 self.present(alert, animated: true, completion: nil)
                             } else {
                                
                            print(response.value)
                            var respone = response.value as? NSDictionary
                            print(respone)
                                
                                var products = respone!["data"] as! NSArray
                                for produc in products ?? [] {
                                    var item = produc as! NSDictionary
                                    var product = item["product"] as? NSDictionary
                                    self.totalpriceArray.append((item["total"] as? Int)!)
                                    self.cartArray.append(cartmodel(id: product!["id"] as? Int, category_id: product!["category_id"] as? Int, name: product!["name"] as? String, image: product!["image"] as? String, description: product!["description"] as? String, price: product!["price"] as? Int, offer: product!["offer"] as? Int, has_offer: product!["has_offer"] as? Bool, created_at: product!["created_at"] as? String, updated_at: product!["updated_at"] as? String))
                                }
                                print(self.cartArray.count)
                                for item in self.totalpriceArray {
                                self.total = self.total + item
                                }
                                self.totalPrice.text = "\(self.total)"
                                self.tableView.reloadData()
            }
        }
    }
    
        func deleteCart(id : String) {
            guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
            }
            
            let headers = ["Authorization": "Bearer \(token)"]
            let getabouturl = "http://climateapp.el-sabat.com/api/cart/\(id)/delete".localized
             print("\(id)")
            Alamofire.request(getabouturl, method: .post, parameters: nil ,headers: headers).responseJSON { response in
                 let result = response.result
                 print("the response is 1 : \(result)")
                 if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                    let Categoriesdata = arrayOfDic["data"] as? [Dictionary<String, AnyObject>]
                    self.tableView.reloadData()
            }
        }
    }
}

extension CartViewC: TableViewProtocol {
    
    func deleteData(indx: Int) {
        deleteCart(id: "\(cartArray[indx].id ?? 0)")
        cartArray.remove(at: indx)
        totalpriceArray.remove(at: indx)
        tableView.reloadData()
        
        self.total = 0
        for item in self.totalpriceArray {
        self.total = self.total + item
        }
        self.totalPrice.text = "\(total)"
   }
}
