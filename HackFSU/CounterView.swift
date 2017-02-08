//
//  CounterView.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 12/30/15.
//  Copyright © 2015 Todd Littlejohn. All rights reserved.
//

import UIKit

class CounterView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    let NoOfGlasses = 8
    let π:CGFloat = CGFloat(M_PI)
    var timesImHere = 3
    
    @IBInspectable var outlineColor: UIColor = UIColor.blueColor()
    @IBInspectable var counterColor: UIColor = UIColor._hackRed()
    
    override func drawRect(rect: CGRect) {
        
        // 1
        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
        
        // 2
        let radius: CGFloat = max(bounds.width, bounds.height)
        
        // 3
        let arcWidth: CGFloat = 40.0
        
        // 4
        let fullTime:CGFloat = NSDate.timeBetween(countdownManager.getHackingStartTime(), date2: countdownManager.getHackingEndTime())
        let timeLeft:CGFloat = globalEventTimeLeft
        // NEED TO TEST CIRCLE UPDATING
        
        var percentLeft:CGFloat!
        
        if countdownManager.hackingHasntStarted() {
            percentLeft = 1.0
            print("U PLAYED YO SELF")
        } else {
            percentLeft = timeLeft / fullTime
        }
        
        if percentLeft > 1.0 {
            percentLeft = 1.0
        } else if percentLeft < 0.0 {
            percentLeft = 0.0
        }
        
        print(percentLeft)
        
        // 5
        let startAngle: CGFloat = 3.0 * π / 2.0
        let endAngle:CGFloat = ( 3.0 * π / 2.0 ) - ( 2.0 * π * percentLeft)
        
        // 6
        let path = UIBezierPath(arcCenter: center,
            radius: radius/2 - arcWidth/2,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: false)
        
        // 7
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
    }
    
//    func drawCircle(time: Int) {
//        // 1
//        let center = CGPoint(x:bounds.width/2, y: bounds.height/2)
//        
//        // 2
//        let radius: CGFloat = max(bounds.width, bounds.height)
//        
//        // 3
//        let arcWidth: CGFloat = 80.0
//        
//        // 4
//        let fullTime:CGFloat = 60 * 60 * 36 // 60 seconds * 60 minutes * 36 hours
//        let timeLeft:CGFloat = CGFloat(time)
//        // NEED TO TEST CIRCLE UPDATING
//        var percentLeft:CGFloat = timeLeft / fullTime
//        
//        if percentLeft > 1.0 {
//            percentLeft = 1.0
//        } else if percentLeft < 0.0 {
//            percentLeft = 0.0
//        }
//        
//        // 5
//        let startAngle: CGFloat = 3.0 * π / 2.0
//        let endAngle: CGFloat = ( 3.0 * π / 2.0 ) - ( 2.0 * π * percentLeft)
//        
//        
//        
//        // 6
//        let path = UIBezierPath(arcCenter: center,
//            radius: radius/2 - arcWidth/2,
//            startAngle: startAngle,
//            endAngle: endAngle,
//            clockwise: false)
//        
//        // 7
//        path.lineWidth = arcWidth
//        counterColor.setStroke()
//        path.stroke()
//    }
    
    
}
