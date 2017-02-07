//
//  HFSponsor.swift
//  Hack FSU
//
//  Created by Todd Littlejohn on 1/4/16.
//  Copyright © 2016 Todd Littlejohn. All rights reserved.
//

import Foundation

class HFSponsor {
    private var sponsorName:String!
    //private var sponsorImageData:UIImage!
    private var sponsorLevel:Int!
    private var sponsorAspectValue:CGFloat!
    private var sizeEvaluated:Bool!
    
    
    init(name: String, level:Int ) {
        sponsorName = name
        //sponsorImageData = image
        sponsorLevel = level
        sizeEvaluated = false
    }
    
    init(name: String) {
        sponsorName = name
    }
    
    func getSponsorName() -> String {
        return self.sponsorName
    }
    
//    func getSponsorImage() -> UIImage {
//        return self.sponsorImageData!
//   }
    
    func getSponsorLevel() -> Int {
        return self.sponsorLevel
    }
    
    func getSizeEvaluated() -> Bool {
        return self.sizeEvaluated
    }
    
    func getSponsorAspectValue() -> CGFloat {
        return self.sponsorAspectValue
    }
    
    func setSponsorAspectValue(value: CGFloat) {
        if value <= 0.0 {
            self.sponsorAspectValue = 0.75
        } else {
            self.sponsorAspectValue = value
        }
    }
    
    func sizeWasEvaluated() {
        self.sizeEvaluated = true 
    }
    
    
}
