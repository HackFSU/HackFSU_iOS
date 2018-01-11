//
//  LoginViewController.swift
//  HackFSU
//
//  Created by Cameron Farzaneh on 10/8/17.
//  Copyright © 2017 HackFSU. All rights reserved.
//

import UIKit
import Alamofire

class LoginVewController: UIViewController {
    
    @IBOutlet var mainLayer: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var logginButton: UIButton!
    var emitter = CAEmitterLayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.layer.cornerRadius = 26.0
        passField.layer.cornerRadius = 26.0
        logginButton.layer.cornerRadius = 26.0
        
        emitter.emitterPosition = CGPoint(x: self.view.frame.size.width / 2, y: -10)
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterSize = CGSize(width: self.view.frame.size.width, height: 2.0)
        emitter.emitterCells = generateEmitterCells()
        
        self.view.layer.insertSublayer(emitter, at: 0)
       
        
   
        
    }
    
    
    @IBAction func loginFam(_ sender: Any) {
        let parameters: Parameters = [
            "email": emailField.text!,
            "password": passField.text!
        ]
        
        API.postRequest(url: URL(string: "https://api.hackfsu.com/api/user/login")!, params: parameters) {
            (statuscode) in
            
            if (statuscode == 200) {
                API.retriveUserInfo()
                let alertController = UIAlertController(title: "HackFSU", message: "Login successful!", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                    //self.dismiss(animated: true, completion: nil)
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "initialNotifications")
                    self.present(controller!, animated: true, completion: nil)
                    
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                
            }
            else {
                let alertController = UIAlertController(title: "HackFSU", message: "Login unsuccessful!", preferredStyle: UIAlertControllerStyle.alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                {
                    (result : UIAlertAction) -> Void in
                    print("You pressed OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /*CONFETTI GENERATOR*/
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells:[CAEmitterCell] = [CAEmitterCell]()
        for index in 0..<16 {
            let cell = CAEmitterCell()
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.velocityRange = 0
            cell.velocity = CGFloat(getRandomVelocity())
            cell.emissionLongitude = CGFloat(Double.pi)
            cell.emissionRange = 0.5
            cell.spin = 2.5
            cell.spinRange = 0
            cell.color = getNextColor(i: index)
            cell.contents = getNextImage(i: index)
            cell.scaleRange = 0.20
            cell.scale = 0.05
            cells.append(cell)
        }
        return cells
    }
    
    enum Images {
        
        static let box = UIImage(named: "Box")!
        static let triangle = UIImage(named: "Triangle")!
        static let circle = UIImage(named: "Circle")!
        static let swirl = UIImage(named: "Spiral")!
        
    }
    
    var velocities:[Int] = [
        100,
        90,
        150,
        200
    ]
    
    private func getRandomVelocity() -> Int {
        return velocities[getRandomNumber()]
    }
    
    private func getRandomNumber() -> Int {
        return Int(arc4random_uniform(4))
    }
    
    private func getNextColor(i:Int) -> CGColor {
        if i <= 4 {
            return  #colorLiteral(red:0.70, green:0.49, blue:0.98, alpha:1.0)
        } else if i <= 8 {
            return  #colorLiteral(red:1.00, green:0.38, blue:0.82, alpha:1.0)
        } else if i <= 12 {
            return  #colorLiteral(red:1.00, green:0.95, blue:0.19, alpha:1.0)
        } else {
            return #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    private func getNextImage(i:Int) -> CGImage {
        if i <= 4 {
            return  Images.box.cgImage!
        } else if i <= 8 {
            return  Images.circle.cgImage!
        } else if i <= 12 {
            return  Images.box.cgImage!
        } else {
            return Images.triangle.cgImage!
        }
    }

    
    
}


