//
//  TrackYourOrdersVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class TrackYourOrdersVC: UIViewController, UITableViewDataSource {

    var img =  [UIImage(named: "image_water")]
    var lblD = [("Almanakh Pure Life Purified Water 500ml".localized)]
    let lblN = [("7".localized)]
    let lblP = [("RS".localized)]
    
    var proArray = [productModel]()
    var orderTrackingModel: OrderTrackingModel?
    let headers = ["Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImY5ZGQzMzEzYTcxMjdjZDllYTk0NTMzMDllYmNkM2YzNGMzOGNhMDM3NjA1YjExN2Q5NjFmMDkxZTE2ZjE0MDkxMjgwNjNlOTRkYWEwMGVlIn0.eyJhdWQiOiIxIiwianRpIjoiZjlkZDMzMTNhNzEyN2NkOWVhOTQ1MzMwOWViY2QzZjM0YzM4Y2EwMzc2MDViMTE3ZDk2MWYwOTFlMTZmMTQwOTEyODA2M2U5NGRhYTAwZWUiLCJpYXQiOjE1NzcyNzkyODEsIm5iZiI6MTU3NzI3OTI4MSwiZXhwIjoxNjA4OTAxNjgxLCJzdWIiOiI3NyIsInNjb3BlcyI6W119.gWxdCSABzklwRbvqX72Jl2iR0DL2KSS-WhgcDiTj7XILy61S22yVvd7O3N1OL2kWJ-hhrm4tvrj9tyw2yKIsWNOk5tRVLOpgU58AmHCUksLvoSQcdnSavHib21CLSiEggw21t-Mvxc-e7Qxi-d9MQyHyNnoyrjnjnXwGF1gC_3IXgo3re0o8Xpoji64hxRbSjJFHPvZ9nodoKO25jt11UnWg-5-Y7Cfw1Kb7RBJXIb_WekQcuEjnI0KMZNyaH9-oKTz7bUsUWOfSxwPYmpf76Ur5WiuqsFLmtg7Ns22bES3RO3b4jqCpMBi7_WlUgJ-bt-xC41AcJ9CqBRlBQ9UZbYaSNFfOv_y6zCnav6uSJjjwjkgPepFYYdQsp2uP2cP8y3kfYFKENIrtMJxF0-udw5Zr2gPgnDMo52uatvzw3EC4Gzlk0oZcUGX9X4BLs819HIL56-Y3nKFSdh8Rl7ixox_iPO_C88rCEmBC8AHl2khzkpTEQCLLPfe7YK3E8yqbotHigrBuArM5xnx_pLlEfVQIx1T_GSV7cKuXoEQRlafkuzRkFC8-05fU_ezlrimfxzs-FWpJm-IP4l8iqu1eZK12GFbss_jHDV8LUU3_XgkQZZhSnePNnLDdgjFX-J7QUzKFGWneelOdpdCFKPUdMMbBvf9jvwgiFV_gqZTAJ4U"]
    //MARK: - NEW CODABLE
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        APIService.instance.getOrderStatus(url: NetworkingConstant.baseURL + NetworkingConstant.orderStatus, headers: headers, method: .get) { (orderTrackingModel, error) in
            if let internetError = error {
                // create alert to show internet message
            } else {
                guard let orderTrackingModel = orderTrackingModel else { return }
                // Im sure that there are data
                self.orderTrackingModel = orderTrackingModel
                self.tableView.reloadData()
            }
        }
        
        

        //getAllnotifications()
        
        tableView.tableFooterView = UIView()
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 270
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderTrackingModel?.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCellOrder else { return UITableViewCell() }
        cell.selectionStyle = .none
        if let singleOrderStatus = orderTrackingModel?.data?[indexPath.row] {
           cell.configureCell(singleOrderStatus: singleOrderStatus)
        }
//        cell?.lbl1.text = lblD[indexPath.row]
//        cell?.lbl2.text = lblN[indexPath.row]
//        cell?.lbl3.text = lblP[indexPath.row]
//        cell?.img.image = img[indexPath.row]
        
        return cell
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
extension TrackYourOrdersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let orderDetailsVC = storyboard?.instantiateViewController(withIdentifier: "OrderDetailsVC") as? OrderDetailsVC {
            orderDetailsVC.orderProducts = orderTrackingModel?.data?[indexPath.row].orderProducts
            present(orderDetailsVC, animated: true, completion: nil)
            
        }
    }
}
extension TrackYourOrdersVC {
    
    func getAllnotifications() {
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        
        
        let getabouturl = "https://climateapp.el-sabat.com/api/orders".localized
        Alamofire.request(getabouturl, method: .get, parameters: nil ,headers: headers).responseJSON { response in
            let result = response.result
            print("the response is 1 : \(result)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                let Categoriesdata = arrayOfDic["data"] as? [Dictionary<String, AnyObject>]
                for aDic1 in Categoriesdata!{
                    var item = aDic1 as! NSDictionary
                    print(item)
                }
                self.tableView.reloadData()
            }
        }
    }
}
