//
//  ReminderSettings.swift
//  climateWater
//
//  Created by Khaled Ghoniem on 12/27/19.
//  Copyright © 2019 Khaled Ghoniem. All rights reserved.
//

import UIKit
import UserNotifications

class ReminderSettings: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    var events = [eventObject]()
    var userDefaults = UserDefaults.standard
    var dateFormatter = DateFormatter()
    var isAdded = false
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
               pulse.duration = 0.6
               pulse.fromValue = 0.95
               pulse.toValue = 1.0
               pulse.autoreverses = true
               pulse.repeatCount = 10
               pulse.initialVelocity = 0.5
               pulse.damping = 1.0
               image.layer.add(pulse, forKey: "pulse")
        
        self.navigationItem.setHidesBackButton(true, animated:false);
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comingUpCell")
        cell?.textLabel?.text = (events[indexPath.row] as! eventObject).eventName
        
        if (events[indexPath.row].isOverdue) {
            cell?.detailTextLabel?.textColor = UIColor.red
        } else {
            cell?.detailTextLabel?.textColor = UIColor.black
        }
      
        cell?.detailTextLabel?.text = dateFormatter.string(from: (events[indexPath.row] as! eventObject).eventDate)
      
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            events.remove(at: indexPath.row)
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: events)
            userDefaults.set(encodedData, forKey: "events4")
            userDefaults.synchronize()
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        
        print(userDefaults.object(forKey: "events4") != nil)

        if(userDefaults.object(forKey: "events4") != nil){
            let decoded = userDefaults.object(forKey: "events4") as? Data
            events = (NSKeyedUnarchiver.unarchiveObject(with: decoded!) as? [eventObject])!
            tableView.reloadData()
            events = events.sorted(by: { $0.eventDate.compare($1.eventDate) == ComparisonResult.orderedAscending})
            
        } else {
    }
        
       UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
    }
    
    @IBAction func backButton(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ReminderVC") as! ReminderVC
        self.present(nextvc,animated: false,completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func gotoNewEvent(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class TableViewControllerTemp: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
