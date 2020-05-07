//
//  secondViewController.swift
//  climateWater
//
//  Created by Ahmed on 12/27/19.
//  Copyright © 2019 Ahmed. All rights reserved.
//

import UIKit
import UserNotifications

class secondViewController: UIViewController {
    
    var isAction:Bool = false
       
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var maleBtn: UIButton!
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var enterdWieght: UITextField!
    @IBOutlet weak var enteredName: UITextField!
    @IBOutlet weak var enteredDate: UITextField!
    
    var events = [eventObject]()
    var datePicker = UIDatePicker()
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 10
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        image.layer.add(pulse, forKey: "pulse")
    }
    
    let dateFormatter = DateFormatter()
    var userDefaults = UserDefaults.standard
    var isAdded = false
    
    func loadevents() {
        var newTask = eventObject(eventName: enteredName.text!, eventDate: datePicker.date)
        if(userDefaults.object(forKey: "events4") != nil){
        let decoded = userDefaults.object(forKey: "events4") as? Data
        events = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [eventObject]
        }
        
        events.append(newTask!)
        
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: events)
        userDefaults.set(encodedData, forKey: "events4")
        userDefaults.synchronize()
        
        let notification = UILocalNotification()
        notification.alertBody = "\(enteredName.text!)"
        notification.alertAction = "open".localized
        var dateInfo = DateComponents()
        dateInfo.hour = 18
        dateInfo.minute = 30
        notification.fireDate = datePicker.date
        notification.soundName = "Addtocart.mp3"
        notification.userInfo = ["title": enteredName.text!]
        UIApplication.shared.scheduleLocalNotification(notification)
        
        let storyBoard : UIStoryboard = UIStoryboard (name : "Main",bundle : nil)
        let nextvc = storyBoard.instantiateViewController(withIdentifier: "ReminderSettings") as! ReminderSettings
        self.present(nextvc,animated: false,completion: nil)
    }
    
    @IBAction func maleBtn(_ sender: UIButton) {
        
        if femaleBtn.isSelected {
                   femaleBtn.isSelected = false
                   maleBtn.isSelected = true
               }else{
                   maleBtn.isSelected = true
               }
           }

    @IBAction func femaleBtn(_ sender: UIButton) {
        
       if maleBtn.isSelected {
               maleBtn.isSelected = false
               femaleBtn.isSelected = true
           }else{
               femaleBtn.isSelected = true
           }
       }
    
    @IBAction func goBackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoTable" {
            let destination = segue.destination as? ReminderSettings
            destination?.isAdded = true
        }
    }
   
    @IBAction func addEventButton(_ sender: UIButton) {
        
        sender.flash()

        if ((enterdWieght.text?.isEmpty)! || (enteredName.text?.isEmpty)! || (enteredDate.text?.isEmpty)!) {
            let alert = UIAlertController(title: "Error".localized, message: "please enter all of your information".localized, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK".localized, style: .cancel, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: false, completion: nil)
        } else {
        loadevents()
        }
    }
    
    func tableDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: datePicker.date)
        enteredDate.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    func createDatePicker () {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelector))
        toolbar.setItems([done], animated: false)
        enteredDate.inputAccessoryView = toolbar
        enteredDate.inputView = datePicker
    }
    
    @objc func doneSelector() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        let dateString = formatter.string(from: datePicker.date)
        enteredDate.text = "\(dateString)"
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
//        maleBtn.layer.shadowColor = UIColor.red.cgColor
//        maleBtn.layer.shadowOpacity = 0.4
//        maleBtn.layer.shadowOffset = .zero
//        maleBtn.layer.shadowRadius = 6
//        maleBtn.layer.shouldRasterize = true
//        maleBtn.layer.rasterizationScale = UIScreen.main.scale
//        maleBtn.layer.cornerRadius = 7.5
//
//        femaleBtn.layer.shadowColor = UIColor.red.cgColor
//        femaleBtn.layer.shadowOpacity = 0.4
//        femaleBtn.layer.shadowOffset = .zero
//        femaleBtn.layer.shadowRadius = 6
//        femaleBtn.layer.shouldRasterize = true
//        femaleBtn.layer.rasterizationScale = UIScreen.main.scale
//        femaleBtn.layer.cornerRadius = 7.5
        
        createDatePicker()
        
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        
        let secondViewController = self.source
        let ViewController = self.destination
        secondViewController.view.superview?.insertSubview(ViewController.view, aboveSubview: secondViewController.view)
        ViewController.view.transform = CGAffineTransform(translationX: -secondViewController.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                        ViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)},
                       completion: {finished in
                        secondViewController.present(ViewController, animated: false, completion: nil)}
        )
    }
}

class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        
        let ViewController = self.source
        let secondViewController = self.destination
        ViewController.view.superview?.insertSubview(secondViewController.view, aboveSubview: ViewController.view)
        secondViewController.view.transform = CGAffineTransform(translationX: ViewController.view.frame.size.width, y: 0)
        UIView.animate(withDuration: 0.25,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                        secondViewController.view.transform = CGAffineTransform(translationX: 0, y: 0)},
                       completion: {finished in
                        ViewController.present(secondViewController, animated: false, completion: nil)}
        )
    }
}
