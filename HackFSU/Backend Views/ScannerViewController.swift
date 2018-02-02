//
//  ScannerViewController.swift
//  HackFSU
//
//  Created by Andres Ibarra on 1/31/18.
//  Copyright © 2018 HackFSU. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerViewController: UIViewController  {
    
    var stringURL: String!
    
    @IBOutlet var signedInLabel: UILabel!
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
        
       
        
        returntoAdminPanel.layer.cornerRadius = 30.0
        returntoAdminPanel.layer.masksToBounds = true
        
        if #available(iOS 10.2, *) {
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
            
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
            
            if metadataObj.stringValue != nil {
                print(metadataObj.stringValue!)
                print(metadataObj)
                
                //obviously this will be the actual name, when we look it up
                hackerNameLabel.text = metadataObj.stringValue!
                signedInLabel.isHidden = false
                hackerNameLabel.isHidden = false

                
                
                
                //self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    
    
    
    
}
