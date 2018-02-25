//
//  ScannerViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 1/31/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class ScannerViewController: UIViewController, UITextFieldDelegate  {

    var stringURL: String!
    var id: Int = 0
    
    @IBOutlet var manualHexField: UITextField!
    
    @IBOutlet var continueScanningButton: UIButton!
    
    @IBOutlet var submitHexcodeButton: UIButton!
    //signed in will hold the hackers name
    @IBOutlet var signedInLabel: UILabel!
    //HackerName will hold the return message after the POST
    @IBOutlet var hackerNameLabel: UILabel!
    var captureSession = AVCaptureSession()
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    @IBOutlet var cameraView: UIView!
    
    @IBOutlet var returntoAdminPanel: UIButton!
    
    enum error: Error{
        case noCameraAvailable
        case videoInputInitFail
    }
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        signedInLabel.isHidden = true
        hackerNameLabel.isHidden = true
        
        manualHexField.layer.cornerRadius = 26.0
        manualHexField.delegate = self
        
        
        returntoAdminPanel.layer.cornerRadius = 30.0
        returntoAdminPanel.layer.masksToBounds = true
        
        continueScanningButton.layer.cornerRadius = 30.0
        continueScanningButton.layer.masksToBounds = true
        
        continueScanningButton.layer.isHidden = true
        
        submitHexcodeButton.layer.cornerRadius = 10.0
        submitHexcodeButton.layer.masksToBounds = true
        
        
        if #available(iOS 10.2, *) {
            
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: .back)
            
            //let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInDuoCamera], mediaType: AVMediaType.video, position: .back)
            
            
            //print(deviceDiscoverySession.devices)
            guard let captureDevice = deviceDiscoverySession.devices.first else {
                print("Failed to get the camera device")
                return
            }
            do {
                // Get an instance of the AVCaptureDeviceInput class using the previous device object.
                let input = try AVCaptureDeviceInput(device: captureDevice)
                
                // Set the input device on the capture session.
                captureSession.addInput(input)
                
                let captureMetadataOutput = AVCaptureMetadataOutput()
                captureSession.addOutput(captureMetadataOutput)
                
                captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
                
                // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer?.frame = cameraView.layer.bounds
                cameraView.layer.addSublayer(videoPreviewLayer!)
                
                
                // Start video capture.
                captureSession.startRunning()
                
                qrCodeFrameView = UIView()
                
                if let qrCodeFrameView = qrCodeFrameView {
                    qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                    qrCodeFrameView.layer.borderWidth = 2
                    view.addSubview(qrCodeFrameView)
                    view.bringSubview(toFront: qrCodeFrameView)
                }
                
                
            } catch {
                // If any error occurs, simply print it out and don't continue any more.
                print(error)
                return
            }
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func clickedReturn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

    
    @IBAction func clickedScanNext(_ sender: UIButton) {
        self.continueScanningButton.layer.isHidden = true
        qrCodeFrameView?.frame = CGRect.zero
        self.signedInLabel.isHidden = true
        self.hackerNameLabel.isHidden = true
       
        
        captureSession.startRunning()
        
    }
    
    
    @IBAction func clickedSubmit(_ sender: Any) {
        if let manualHex = manualHexField.text {
            let parameters = [
                "event": id,
                "hacker" : manualHex
                ] as [String : Any]
            
            API.postRequest(url: URL(string: routes.scanURL)!, params: parameters) {
                (statuscode) in
                
                if statuscode == 200 {
                    self.hackerNameLabel.text = manualHex
                    self.signedInLabel.isHidden = false
                    self.hackerNameLabel.isHidden = false
                    self.continueScanningButton.layer.isHidden = false
                    self.view.endEditing(true)
                    self.captureSession.stopRunning()
                }
            }
            
        }
    }
    
}

extension ScannerViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            //If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            //print(metadataObj)
            if metadataObj.stringValue != nil {
                // Stop video capture.
                captureSession.stopRunning()
                
                let parameters = [
                    "event": id,
                    "hacker" : metadataObj.stringValue!
                    ] as [String : Any]

                Alamofire.request(routes.scanURL, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseJSON(completionHandler: {
                    response in
                    let statusCode = response.response?.statusCode
                    let responseData = response.result.value as! Dictionary<String,Any>
                    
                    //print(responseData!)
            
                    
                    if (responseData["status"] as! Int) == 200{
                        self.hackerNameLabel.text = (responseData["message"] as! String)
                        self.signedInLabel.text = (responseData["name"] as! String)
                        self.signedInLabel.isHidden = false
                        self.hackerNameLabel.isHidden = false
                        self.continueScanningButton.layer.isHidden = false
                    }
                    else if (responseData["status"] as! Int) == 401{
                        //already did the event
                        self.hackerNameLabel.text = (responseData["message"] as! String)
                        self.signedInLabel.text = (responseData["name"] as! String)
                        self.signedInLabel.isHidden = false
                        self.hackerNameLabel.isHidden = false
                        self.continueScanningButton.layer.isHidden = false
                    }else{
                        //something is wrong
                        self.hackerNameLabel.text = (responseData["message"] as! String)
                        self.signedInLabel.text = (responseData["name"] as! String)
                        self.signedInLabel.isHidden = false
                        self.hackerNameLabel.isHidden = false
                        self.continueScanningButton.layer.isHidden = false
                    }

                })
                
            }
        }
    }
    
    
    
    
    
    
}
