//
//  PostAnnouncement.swift
//  HackFSU
//
//  Created by Andres Ibarra on 2/12/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit
import Alamofire

class PostAnnouncement: UIViewController, UITextFieldDelegate{

    @IBOutlet var announcementTitle: UITextField!
    
    @IBOutlet var announcementDescription: UITextField!
    
    @IBOutlet var isANotificationSwitch: UISwitch!
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var returnButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        announcementDescription.delegate = self
        announcementTitle.delegate = self
        
        announcementDescription.layer.cornerRadius = 20
        announcementDescription.layer.masksToBounds = true
        
        announcementTitle.layer.cornerRadius = 20
        announcementTitle.layer.masksToBounds = true
        
        submitButton.layer.cornerRadius = 20
        submitButton.layer.masksToBounds = true
        
        returnButton.layer.borderWidth = 2
        returnButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        returnButton.layer.cornerRadius = 15
        returnButton.layer.masksToBounds = true
        
        isANotificationSwitch.setOn(false, animated: false)
    }


    @IBAction func clickedSubmit(_ sender: Any) {
       
        if announcementTitle.text != ""{
            if announcementDescription.text != ""{
                let title = announcementTitle.text
                let description = announcementDescription.text
                
                let parameters: Parameters
                if isANotificationSwitch.isOn {
                    parameters = [
                        "title": title!,
                        "body": description!,
                        "isUpdate": 1
                    ]
                }
                else {
                    parameters = [
                        "title": title!,
                        "body": description!,
                        "isUpdate": 0
                    ]
                }
        
                API.postRequest(url: URL(string: routes.newPushNoti)!, params: parameters) {
                    (statuscode) in
                    
                    if (statuscode == 200) {
                        let alertController = UIAlertController(title: "Announcement Posted!", message: "Thank you!", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Return", style: UIAlertActionStyle.default){
                            (result : UIAlertAction) -> Void in
                            self.view.endEditing(true)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    else {
                        let alertController = UIAlertController(title: "Uh oh!", message: "An error has occured with status code: \(statuscode)", preferredStyle: UIAlertControllerStyle.alert)
                        let okAction = UIAlertAction(title: "Return", style: UIAlertActionStyle.default){
                            (result : UIAlertAction) -> Void in
                            self.view.endEditing(true)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                
                isANotificationSwitch.setOn(false, animated: false)
                announcementTitle.text = nil
                announcementDescription.text = nil
                
            }
   
        }
        
        
    }
    
    func moveTextField(textField: UITextField, distance: Int, up: Bool){
        let duration = 0.3
        let movement: CGFloat = CGFloat(up ? -distance : distance)
        UIView.beginAnimations("animateKeyboard", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(duration)
        self.view.frame = (self.view.frame).offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 4{
            moveTextField(textField: textField, distance: 40, up: false)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         if textField.tag == 4{
            moveTextField(textField: textField, distance: 40, up: true)
         }
    }

    // DESCRIPTION:
    // Called when the editing is done on a textfield
    // and the return button is clicked to remove the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
}
