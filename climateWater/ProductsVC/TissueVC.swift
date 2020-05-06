//
//  TissueVC.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import Alamofire

class TissueVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var WaterproductsMain = [WaterProductsMain]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        getAllWaterProducts()
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
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WaterproductsMain.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell2
        
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 100, 0)
        let rotationAngleRadians = 90.0 * CGFloat(Double.pi/180.0)
        cell.layer.transform = rotationTransform
        UIView.animate(withDuration: 1.0, animations: { cell.layer.transform = CATransform3DIdentity })
        cell.setProduct(product: WaterproductsMain[indexPath.item])
        cell.addtocartout.tag = WaterproductsMain[indexPath.row].id
        cell.contentView.layer.masksToBounds = true
        cell.backgroundColor = UIColor.white
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        cell.delegate = self
        cell.index = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TissueProductsVC") as! TissueProductsVC
        nextViewController.productInfo = WaterproductsMain[indexPath.row]
        nextViewController.pro_id = "\(WaterproductsMain[indexPath.row].id)"
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    func bestFrameSize() -> CGFloat {
        let frameHeight = self.view.frame.height
        let frameWidth = self.view.frame.width
        let bestFrameSize = (frameHeight > frameWidth ) ? frameHeight : frameWidth
        return bestFrameSize
    }
}

extension TissueVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let heightVal = self.view.frame.height
        let widthVal = self.view.frame.width
        let cellsize = (heightVal < widthVal) ?  bounds.height/2 : bounds.width/2
        return CGSize(width: cellsize - 20   , height: 300 )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func getAllWaterProducts(){
        let getabouturl = "https://climateapp.el-sabat.com/api/categories/2/products".localized
        Alamofire.request(getabouturl).responseJSON { response in
            let result = response.result
            print("the response is 1 : \(result)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                let Categoriesdata = arrayOfDic["data"] as? [Dictionary<String, AnyObject>]
                for aDic1 in Categoriesdata!{
                    self.WaterproductsMain.append(WaterProductsMain(
                        id: aDic1["id"] as! Int,
                        category_id: aDic1["category_id"] as! Int,
                        name: aDic1["name"] as! String,
                        description: aDic1["description"] as! String,
                        image: aDic1["image"] as! String,
                        price: aDic1["price"] as! Int,
                        offer: aDic1["offer"] as! Int,
                        has_offer: (aDic1["has_offer"] != nil))
                    )
                }
            }
            
            self.collectionView.reloadData()
            print("??????? : \(self.WaterproductsMain.count)")
        }
    }
}

extension TissueVC {
func AddtoCart(id : String  ){

var addcarturl = "https://climateapp.el-sabat.com/api/cart"
    let parameters = [
        "product_id" : id,
        "quantity" :"1"
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

extension TissueVC: CollectionViewTissue {
    func AddToCartButton(index: Int) {
         guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        AddtoCart(id: "\(WaterproductsMain[index].id)")
    }
}
