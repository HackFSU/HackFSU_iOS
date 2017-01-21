////
////  HFMentorViewController.swift
////  Hack FSU
////
////  Created by Todd Littlejohn on 10/23/15.
////  Copyright © 2015 Todd Littlejohn. All rights reserved.
////
//
//import UIKit
//import Parse
//import BEMCheckBox
//
//class HFMentorViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
//    
//    // MARK: UIOutlets
//    @IBOutlet weak var descriptionTextView: UITextView!
//    @IBOutlet weak var nameTextField: UITextField!
//    @IBOutlet weak var locationTextField: UITextField!
//    @IBOutlet weak var namecheckBox:BEMCheckBox!
//    @IBOutlet weak var locationcheckBox:BEMCheckBox!
//    @IBOutlet weak var descriptioncheckBox:BEMCheckBox!
//    @IBOutlet weak var mentorView: UIView!
//    
//    // MARK: Class Varibles
//    var textViewColor = UIColor._lightGrayColor()
//    var keyboardHeightSize:CGFloat!
//    let tbc = UITabBarController().tabBar.frame.size.height
//    let istextViewSelected = false
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        descriptionTextView.layer.borderWidth = 0.5
//        descriptionTextView.layer.borderColor = self.textViewColor.CGColor
//        descriptionTextView.layer.cornerRadius = 7.5
//        
//        nameTextField.delegate = self // Replace TextField with the name of your textField
//        locationTextField.delegate = self
//        descriptionTextView.delegate = self
//        nameTextField.addTarget(self, action: "nameTextFieldDidEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
//        nameTextField.addTarget(self, action: "nameTextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//        locationTextField.addTarget(self, action: "locationTextFieldDidEnd:", forControlEvents: UIControlEvents.EditingDidEnd)
//        locationTextField.addTarget(self, action: "locationTextFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
//        
//        // Set all checkBox's animation type to Bounce
//        namecheckBox.onAnimationType = BEMAnimationType.Bounce
//        namecheckBox.offAnimationType = BEMAnimationType.Bounce
//        locationcheckBox.onAnimationType = BEMAnimationType.Bounce
//        locationcheckBox.offAnimationType = BEMAnimationType.Bounce
//        descriptioncheckBox.onAnimationType = BEMAnimationType.Bounce
//        descriptioncheckBox.offAnimationType = BEMAnimationType.Bounce
//        
//        // Keyboard stuff.
//        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
//        center.addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//        center.addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
//        center.addObserver(self, selector: "keyboardDidChange:", name: UIKeyboardDidChangeFrameNotification, object: nil)
//        
//        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
//        self.navigationController?.navigationBar.tintColor = .whiteColor()
//    }
//    
//    // Functions for keyboard
//    
//    func keyboardWillShow(notification: NSNotification) {
//        let info:NSDictionary = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        
//        let keyboardHeight: CGFloat = keyboardSize.height
//        
//        self.keyboardHeightSize = keyboardHeight
//        
//        let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
//        
//        print("1")
//        
//    }
//    
//    func keyboardDidShow(notification: NSNotification) {
//        print("2")
//        let info:NSDictionary = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        
//        let keyboardHeight: CGFloat = keyboardSize.height
//        
//        self.keyboardHeightSize = keyboardHeight
//        
//        
//            //let _: CGFloat = info[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber as CGFloat
//            //UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//              //  self.mentorView.frame = CGRectMake(0, (-self.keyboardHeightSize + self.tbc), self.view.bounds.width, self.view.bounds.height)
//                
//                //}, completion: nil)
//  
//    }
//    
//    func keyboardDidChange(notification: NSNotification) {
//        let info:NSDictionary = notification.userInfo!
//        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
//        let height:CGFloat = keyboardSize.height
//        //print(height)
//        print("3")
//    }
//    
//    // Functions for textView
//    
//    func textViewDidBeginEditing(textView: UITextView) {
//        
//        UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//            self.mentorView.frame = CGRectMake(0, (-self.keyboardHeightSize + self.tbc), self.view.bounds.width, self.view.bounds.height)
//            
//            }, completion: nil)
//    }
//    
//    func textViewDidEndEditing(textView: UITextView) {
//        if descriptionTextView.text == "" {
//            descriptioncheckBox.setOn(false, animated:true)
//        }
//        else {
//            descriptioncheckBox.setOn(true, animated:true)
//        }
//        UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
//            self.mentorView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
//            
//            }, completion: nil)
//    }
//    
//    func textViewDidChange(textView: UITextView) {
//        if descriptionTextView.text == "" {
//            descriptioncheckBox.setOn(false, animated:true)
//        }
//    }
//    
//    //Textfield
//    
//    func nameTextFieldDidEnd(textField: UITextField) {
//        if nameTextField.text == "" {
//            namecheckBox.setOn(false, animated:true)
//        }
//        else {
//            if namecheckBox.on {
//            }
//            else {
//                namecheckBox.setOn(true, animated:true)
//            }
//        }
//    }
//    
//    func nameTextFieldDidChange(textField: UITextField) {
//        if nameTextField.text == "" {
//            namecheckBox.setOn(false, animated:true)
//        }
//    }
//    
//    func locationTextFieldDidEnd(textField: UITextField) {
//        if locationTextField.text == "" {
//            locationcheckBox.setOn(false, animated:true)
//        }
//        else {
//            if locationcheckBox.on {
//            }
//            else {
//                locationcheckBox.setOn(true, animated:true)
//            }
//        }
//    }
//    
//    func locationTextFieldDidChange(textField: UITextField) {
//        if locationTextField.text == "" {
//            locationcheckBox.setOn(false, animated:true)
//        }
//    }
//    
//    ////////////////////////////////////////////////////////////////////////////////////////////////////
//    
//    override func viewWillDisappear(animated: Bool) {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
//    }
//    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.descriptionTextView.resignFirstResponder()
//        self.nameTextField.resignFirstResponder()
//        self.locationTextField.resignFirstResponder()
//    }
//    
//    // Will send help request if all the fields are correctly filled out
//    @IBAction func processHelpRequest(sender: AnyObject) {
//        if checkFeildsForRequiredLength() {
//            sendHelpRequest()
//        } else {
//            
//        }
//    }
//    
//    // Function to switch textFields when tapping return button on keyboard
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        let nextTag: NSInteger = textField.tag + 1;
//        // Try to find next responder
//        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
//            if (nextResponder != nil) {
//                // Found next responder, so set it.
//                nextResponder.becomeFirstResponder()
//            }
//        }
//        else {
//            // Not found, so remove keyboard.
//            textField.resignFirstResponder()
//        }
//        return false; // We do not want UITextField to insert line-breaks.
//    }
//    
//    func checkFeildsForRequiredLength() -> Bool {
//        // Maximum text field lengths
//        let nameTextFieldMaxSize:Int = 100
//        let locationTextFieldMaxSize:Int = 100
//        let descriptionTextFieldMaxSize:Int = 2000
//        
//        let nameTextFieldSize:Int = nameTextField.text!.characters.count
//        let nameTextFieldIsCorrectLength:Bool = nameTextFieldSize > 0 && nameTextFieldSize <= nameTextFieldMaxSize
//        
//        let locationTextFieldSize:Int = locationTextField.text!.characters.count
//        let locationTextFieldIsCorrectLength:Bool = locationTextFieldSize > 0 && locationTextFieldSize <= locationTextFieldMaxSize
//        
//        let descriptionTextFieldSize:Int = descriptionTextView.text!.characters.count
//        let descriptionTextFieldIsCorrectLength:Bool = descriptionTextFieldSize > 0 && descriptionTextFieldSize <= descriptionTextFieldMaxSize
//        
//        var alertMessage:String!
//        
//        /* Need to add cases to display errors for poorly filled out text fields */
//        if nameTextFieldIsCorrectLength && locationTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
//            return true
//        } else if nameTextFieldIsCorrectLength && locationTextFieldIsCorrectLength {
//            // name and location are correct
//            alertMessage = "Please add a description of your help request under \(descriptionTextFieldMaxSize) characters."
//        } else if nameTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
//            // name and description are correct
//            alertMessage = "Please specify your location in under \(locationTextFieldMaxSize) characters."
//        } else if locationTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
//            // location and description are correct
//            alertMessage = "Please fill in your name in under \(nameTextFieldMaxSize) characters."
//        } else {
//            // multiple feilds are not filled out correctly
//            alertMessage = "There are multiple text fields not filled out properly."
//        }
//        
//        presentAlert("Properly Fill Out Text Field", alertMessage: alertMessage)
//        
//        return false
//    }
//    
//    func sendHelpRequest() {
//        let request = HelpRequest(name: nameTextField.text!, location: locationTextField.text!, description: descriptionTextView.text!)
//        
//        request.saveInBackgroundWithBlock { (sucess, error) -> Void in
//            if sucess {
//                self.emptyTextFields()
//                self.presentAlert("Help Request Sucessful", alertMessage: "Keep an eye out for your mentor!")
//                
//            } else {
//                self.presentAlert("Help Request Not Sucessful :(", alertMessage: "We couldn't process your help request. Make sure you're connected to wifi and try again. If this problem persists, come to the mentor room!")
//            }
//        }
//    }
//    
//    func presentAlert(title: String, alertMessage: String) {
//        let alertController = UIAlertController(title: title, message:
//            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
//        
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//        
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }
//    
//    func emptyTextFields() {
//        self.nameTextField.text = ""
//        self.locationTextField.text = ""
//        self.descriptionTextView.text = ""
//    }
//}


//
//  HFMentorViewController.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 10/23/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit
import Parse
import BEMCheckBox

class HFMentorViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: UIOutlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var namecheckBox:BEMCheckBox!
    @IBOutlet weak var locationcheckBox:BEMCheckBox!
    @IBOutlet weak var descriptioncheckBox:BEMCheckBox!
    @IBOutlet weak var mentorView: UIView!
    @IBOutlet weak var desLabeltoLocTFCon: NSLayoutConstraint!
    
    @IBOutlet weak var desButtonLocTFCon: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: Class Varibles
    var textViewColor = UIColor._lightGrayColor()
    var keyboardHeightSize:CGFloat!
    let tbc = UITabBarController().tabBar.frame.size.height
    let nbc = UINavigationController().navigationBar.frame.size.height
    var istextViewSelected = false
    var suggestionKeyboard:CGFloat!
    var sugKeyUp = false
    var textViewHasShrunk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.layer.borderWidth = 0.5
        descriptionTextView.layer.borderColor = self.textViewColor.CGColor
        descriptionTextView.layer.cornerRadius = 7.5
        
        nameTextField.delegate = self // Replace TextField with the name of your textField
        locationTextField.delegate = self
        descriptionTextView.delegate = self
        nameTextField.addTarget(self, action: #selector(HFMentorViewController.nameTextFieldDidEnd(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        nameTextField.addTarget(self, action: #selector(HFMentorViewController.nameTextFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        locationTextField.addTarget(self, action: #selector(HFMentorViewController.locationTextFieldDidEnd(_:)), forControlEvents: UIControlEvents.EditingDidEnd)
        locationTextField.addTarget(self, action: #selector(HFMentorViewController.locationTextFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        // Set all checkBox's animation type to Bounce
        namecheckBox.onAnimationType = BEMAnimationType.Fill
        namecheckBox.offAnimationType = BEMAnimationType.Fill
        locationcheckBox.onAnimationType = BEMAnimationType.Fill
        locationcheckBox.offAnimationType = BEMAnimationType.Fill
        descriptioncheckBox.onAnimationType = BEMAnimationType.Fill
        descriptioncheckBox.offAnimationType = BEMAnimationType.Fill
        
        // Keyboard stuff.
        let center: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: #selector(HFMentorViewController.keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        // Nav bar 
        self.navigationController?.navigationBar.barTintColor = UIColor._hackRed()
        self.navigationItem.title = "HELP REQUEST"
        let attributesDictionary = [NSFontAttributeName: UIFont(name: "UniSansHeavyCAPS", size: 25)!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = attributesDictionary
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        
        self.nameLabel.textColor = UIColor._hackPurp()
        self.descriptionLabel.textColor = UIColor._hackPurp()
        self.locationLabel.textColor = UIColor._hackPurp()
        
    }
    
    // Functions for keyboard
    
    func keyboardDidShow(notification: NSNotification) {
        
        let info:NSDictionary = notification.userInfo!
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let keyboardHeight: CGFloat = keyboardSize.height
        
        isSugKeyboardUp(keyboardHeight)
        
        self.keyboardHeightSize = keyboardHeight
        
        if istextViewSelected == true {
            
            
            UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.mentorView.frame = CGRectMake(0, (-self.keyboardHeightSize + self.tbc), self.view.bounds.width, self.view.bounds.height)
                
                }, completion: nil)
            
            UIView.animateWithDuration(0.25, delay: 0.25, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.mentorView.frame = CGRectMake(0, (-self.keyboardHeightSize + self.tbc), self.view.bounds.width, self.view.bounds.height)
                }, completion: { (truth:Bool) -> Void in
                    if self.sugKeyUp == true && self.textViewHasShrunk == false {
                        self.shrinkTextView()
                    } else if self.sugKeyUp == true && self.textViewHasShrunk == true  {
                        
                    } else if self.sugKeyUp == false && self.textViewHasShrunk == false {
                        
                    } else if self.sugKeyUp == false && self.textViewHasShrunk == true {
                        self.growTextView()
                    }
            })
        }
        else {
            
        }
    }
    
    func shrinkTextView() {
        
        desLabeltoLocTFCon.constant = desLabeltoLocTFCon.constant + suggestionKeyboard
        
        desButtonLocTFCon.constant = desButtonLocTFCon.constant + suggestionKeyboard
        
        textViewHasShrunk = true
    }
    
    func growTextView() {
        
        desLabeltoLocTFCon.constant = desLabeltoLocTFCon.constant - suggestionKeyboard
        
        desButtonLocTFCon.constant = desButtonLocTFCon.constant - suggestionKeyboard
        
        textViewHasShrunk = false
    }
    
    // Functions for textView
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        self.istextViewSelected = true
        
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        self.istextViewSelected = false
        
        if descriptionTextView.text == "" {
            descriptioncheckBox.setOn(false, animated:true)
        }
        else {
            descriptioncheckBox.setOn(true, animated:true)
        }
        
        UIView.animateWithDuration(0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.mentorView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
            
            }, completion: nil)
        
        desButtonLocTFCon.constant = 36
        desLabeltoLocTFCon.constant = 36
        
        textViewHasShrunk = false
        
    }
    
    func textViewDidChange(textView: UITextView) {
        if descriptionTextView.text == "" {
            
            descriptioncheckBox.setOn(false, animated:true)
            
        }
    }
    
    //Textfield
    
    func nameTextFieldDidEnd(textField: UITextField) {
        if nameTextField.text == "" {
            namecheckBox.setOn(false, animated:true)
            
        }
        else {
            if namecheckBox.on {
            }
            else {
                
                namecheckBox.setOn(true, animated:true)
            }
        }
    }
    
    func isSugKeyboardUp(height: CGFloat) -> Bool {
        
        suggestionKeyboard = setSuggestionBarHeight(height)
        
        if height < 240.0 {
            sugKeyUp = false
            return false
            
        } else {
            sugKeyUp = true
            return true
        }
    }
    
    func nameTextFieldDidChange(textField: UITextField) {
        if nameTextField.text == "" {
            
            namecheckBox.setOn(false, animated:true)
            
        }
    }
    
    func locationTextFieldDidEnd(textField: UITextField) {
        if locationTextField.text == "" {
            
            locationcheckBox.setOn(false, animated:true)
            
        }
        else {
            if locationcheckBox.on {
            }
            else {
                
                locationcheckBox.setOn(true, animated:true)
            }
        }
    }
    
    func locationTextFieldDidChange(textField: UITextField) {
        if locationTextField.text == "" {
            
            locationcheckBox.setOn(false, animated:true)
            
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    override func viewWillDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.descriptionTextView.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.locationTextField.resignFirstResponder()
    }
    
    // Will send help request if all the fields are correctly filled out
    @IBAction func processHelpRequest(sender: AnyObject) {
        if checkFeildsForRequiredLength() {
            sendHelpRequest()
        } else {
            
        }
    }
    
    // Function to switch textFields when tapping return button on keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print(textField.tag)
        
        let nextTag: NSInteger = textField.tag + 1;
        // Try to find next responder
        if let nextResponder: UIResponder! = textField.superview!.viewWithTag(nextTag){
            if (nextResponder != nil && nextTag == 2) {
                // Found next responder, so set it.
                self.descriptionTextView.becomeFirstResponder()
                
            } else if (nextResponder != nil) {
                nextResponder.becomeFirstResponder()
            } else if (nextResponder == nil) {
                print("chaco taco")
            }
            print("woo")
        }
        else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        return false; // We do not want UITextField to insert line-breaks.
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let tempString:NSString = text as NSString
        
        if tempString.isEqualToString("\n") {
            textView.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    
    // We used the heights we found of keyboards with and without the suggestion box to determine the hight of the sugestion box.
    func setSuggestionBarHeight(height: CGFloat) -> CGFloat {
        if height == 224.0 || height == 253.0 {
            return 29.0
        } else if height == 225.0 || height == 258.0 {
            return 33.0
        } else {
            return 35.0
        }
    }
    
    func checkFeildsForRequiredLength() -> Bool {
        // Maximum text field lengths
        let nameTextFieldMaxSize:Int = 100
        let locationTextFieldMaxSize:Int = 100
        let descriptionTextFieldMaxSize:Int = 2000
        
        let nameTextFieldSize:Int = nameTextField.text!.characters.count
        let nameTextFieldIsCorrectLength:Bool = nameTextFieldSize > 0 && nameTextFieldSize <= nameTextFieldMaxSize
        
        let locationTextFieldSize:Int = locationTextField.text!.characters.count
        let locationTextFieldIsCorrectLength:Bool = locationTextFieldSize > 0 && locationTextFieldSize <= locationTextFieldMaxSize
        
        let descriptionTextFieldSize:Int = descriptionTextView.text!.characters.count
        let descriptionTextFieldIsCorrectLength:Bool = descriptionTextFieldSize > 0 && descriptionTextFieldSize <= descriptionTextFieldMaxSize
        
        var alertMessage:String!
        
        /* Need to add cases to display errors for poorly filled out text fields */
        if nameTextFieldIsCorrectLength && locationTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
            return true
        } else if nameTextFieldIsCorrectLength && locationTextFieldIsCorrectLength {
            // name and location are correct
            alertMessage = "Please add a description of your help request under \(descriptionTextFieldMaxSize) characters."
        } else if nameTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
            // name and description are correct
            alertMessage = "Please specify your location in under \(locationTextFieldMaxSize) characters."
        } else if locationTextFieldIsCorrectLength && descriptionTextFieldIsCorrectLength {
            // location and description are correct
            alertMessage = "Please fill in your name in under \(nameTextFieldMaxSize) characters."
        } else {
            // multiple feilds are not filled out correctly
            alertMessage = "There are multiple text fields not filled out properly."
        }
        
        presentAlert("Properly Fill Out Text Field", alertMessage: alertMessage)
        
        return false
    }
    
    func sendHelpRequest() {
        let request = HelpRequest(name: nameTextField.text!, location: locationTextField.text!, description: descriptionTextView.text!)
        
        request.saveInBackgroundWithBlock { (sucess, error) -> Void in
            if sucess {
                self.emptyTextFields()
                self.presentAlert("Help Request Sucessful", alertMessage: "Keep an eye out for your mentor!")
                
            } else {
                self.presentAlert("Help Request Not Sucessful :(", alertMessage: "We couldn't process your help request. Make sure you're connected to wifi and try again. If this problem persists, come to the mentor room!")
            }
        }
    }
    
    func presentAlert(title: String, alertMessage: String) {
        let alertController = UIAlertController(title: title, message:
            alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//        alertController.view.tintColor = UIColor._hackRed()
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func emptyTextFields() {
        self.nameTextField.text = ""
        self.locationTextField.text = ""
        self.descriptionTextView.text = ""
        
        self.namecheckBox.setOn(false, animated: true)
        self.locationcheckBox.setOn(false, animated: true)
        self.descriptioncheckBox.setOn(false, animated: true)
        
    }
}
