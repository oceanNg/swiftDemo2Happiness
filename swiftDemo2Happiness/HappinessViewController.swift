//
//  HappinessViewController.swift
//  swiftDemo2Happiness
//
//  Created by duongnguyen on 2/24/16.
//  Copyright © 2016 duongnguyen. All rights reserved.
//

import UIKit



class HappinessViewController: UIViewController, faceViewDataSource
{

    
    @IBOutlet weak var faceView: FaceView!
        {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer (target: faceView, action: "didScale:"))
            
//            faceView .addGestureRecognizer(UIPanGestureRecognizer (target: faceView, action: "changeHappiness:"))
            
        }
    }
    
    //TODO: setup Var

    var happiness: Int = 10
        { // 0 = VERY SAD . 100 = ECSTATIC	
        
            didSet
            {
                happiness = min(max(happiness, 0), 100)
                
                print("happiness = \(happiness)")
                
                updateUI()
            }
        }
    
     private struct Constants {
        
         static let HappinessGestureSacle : CGFloat = 4
    }
    
    // TODO: FUNCTION
    
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer)
    {
        switch sender.state
        {
            case .Ended : fallthrough
            
            case .Changed:
                let translation = sender.translationInView(faceView)
                
                let happinessChange = -Int (translation.y / Constants.HappinessGestureSacle)
            
                if happinessChange != 0
                {
                    happiness += happinessChange
                    
                    sender.setTranslation(CGPointZero, inView: faceView)
            }
        default : break
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateUI()
    {
        faceView.setNeedsDisplay()
        
    }
    
    func smillinessFoFaceView(sender: FaceView) -> Double?
    {
         return Double(happiness-50) / 50
        
        
    }

    
}
