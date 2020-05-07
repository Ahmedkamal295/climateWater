//
//  notificationVC.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class notificationVC: UIViewController , UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var notificationArray = [notificationModel]()
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
  
        getAllnotifications()
        tableView.tableFooterView = UIView()
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 110
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell2
        
        cell?.selectionStyle = .none
        cell?.lbl1.text = notificationArray[indexPath.row].title
        cell?.lbl2.text = notificationArray[indexPath.row].body
        cell?.lbl3.text = notificationArray[indexPath.row].date

        cell?.index = indexPath
        cell?.delegate = self
        
        return cell!
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
        
    
    @IBAction func reminderBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    func getAllnotifications(){
        guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
            let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        let headers = ["Authorization": "Bearer \(token)"]
        let getabouturl = "https://climateapp.el-sabat.com/api/notifications".localized
        Alamofire.request(getabouturl, method: .get, parameters: nil ,headers: headers).responseJSON { response in
            let result = response.result
            print("the response is 1 : \(result)")
            if let arrayOfDic = result.value as? Dictionary<String, AnyObject> {
                let Categoriesdata = arrayOfDic["data"] as? [Dictionary<String, AnyObject>]
                for aDic1 in Categoriesdata!{
                var item = aDic1 as! NSDictionary
                    self.notificationArray.append(notificationModel(id: item["id"] as? String, title: item["title"] as? String, body: item["body"] as? String, date: item["date"] as? String, seen: item["senn"] as? Bool))
                    
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func deleteNotification(id : String){
    guard let token = UserDefaults.standard.object(forKey: "token") as? String else {
        let alert = UIAlertController(title: "Error".localized, message: "Please login to App".localized, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        return
    }
    
        let headers = ["Authorization": "Bearer \(token)"]
        let getabouturl = "https://climateapp.el-sabat.com/api/notifications/i\(id)/delete".localized
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

extension notificationVC: TableViewCellProtocol {
    
        func deleteView(indx:Int) {
            deleteNotification(id: notificationArray[indx].id ?? "")
            notificationArray.remove(at: indx)
        }
    
        @IBAction func btnBack(_ sender: Any) {
            dismiss(animated: false, completion: nil)
        }
    }
