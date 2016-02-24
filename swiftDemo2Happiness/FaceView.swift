//
//  FaceView.swift
//  swiftDemo2Happiness
//
//  Created by duongnguyen on 2/24/16.
//  Copyright © 2016 duongnguyen. All rights reserved.
//

import UIKit
@ IBDesignable

class FaceView: UIView
{

    //TODO: SETUP VAR
    var lineWidth: CGFloat = 3 { didSet {setNeedsDisplay()} }
    
    var color : UIColor = UIColor(red: 0.3, green: 0.2, blue: 0.5, alpha: 1) {didSet{needsUpdateConstraints()}}
    
    // UIColor.redColor()

    
    var scale : CGFloat = 0.90{didSet{needsUpdateConstraints()}}
    

    var faceCenter: CGPoint
        {
        return convertPoint(center, fromCoordinateSpace: superview!)
    }
    
    var faceRadius: CGFloat
        {
         return min(bounds.size.width, bounds.size.height)/2 * scale
    
    }
    
    enum Eye {case Left , Right}

   private struct Scaling
    {
      static let FaceRadiusToEyeRadiusRatio:      CGFloat = 10
    
      static let FaceRadiusToEyeOffsetRatio:      CGFloat = 3
    
      static let FaceRadiusToEyeSeparatioRatio:   CGFloat = 1.5
    
      static let FaceRadiusToEyeMouthWithRatio:   CGFloat = 1
    
      static let FaceRadiusToEyeMouthHeightRatio: CGFloat = 3
    
      static let FaceRadiusToEyeMouthOffsetRatio: CGFloat = 3
    
    }
    
    //TODO: fUNCTION
    override func drawRect(rect: CGRect)
    {
        let facePath = UIBezierPath(arcCenter: faceCenter, radius: faceRadius, startAngle: 0, endAngle:CGFloat( 2*M_PI), clockwise: true)
        
        facePath.lineWidth = lineWidth
        
        color.set()
        
        facePath.stroke()
        
        bezierPathForEye(.Left).stroke()

        bezierPathForEye(.Right).stroke()

        let smiliness = -0.5
        
        let smilePath = bezierPathForSmile(smiliness)
        
        smilePath.stroke()
        
        //        facePath.fill()
        
    }

    
    func bezierPathForEye(whichEye : Eye) -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        
        let eyeVerticalOffser = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio

        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparatioRatio
        
        var eyeCenter = faceCenter
        
        eyeCenter.y -= eyeVerticalOffser
        
        switch whichEye
        {
            case .Left : eyeCenter.x -= eyeHorizontalSeparation / 2
            
            case .Right : eyeCenter.x += eyeHorizontalSeparation  / 2
        }
        
        let path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true)
        
        path.lineWidth = lineWidth
         return path

    }
    
    
    func bezierPathForSmile (fractionOfmaxSmile: Double) -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToEyeMouthWithRatio
        
        let mouthHeight = faceRadius / Scaling.FaceRadiusToEyeMouthHeightRatio
        
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeMouthOffsetRatio
        
        let smileHeight = CGFloat (max(min(fractionOfmaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint (x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        
        let end = CGPoint (x: start.x + mouthWidth, y: start.y)
        
        let cp1 = CGPoint (x:start.x + mouthWidth/3 , y: start.y + smileHeight)
        
        let cp2 = CGPoint (x: end.x - mouthWidth/3, y: cp1.y)
        
        let path = UIBezierPath()
        
        path.moveToPoint(start)
        
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = lineWidth
        
        return path
        
        
        
    }

}
