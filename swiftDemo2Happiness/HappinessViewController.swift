//
//  HappinessViewController.swift
//  swiftDemo2Happiness
//
//  Created by duongnguyen on 2/24/16.
//  Copyright © 2016 duongnguyen. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController {

    //TODO: setup Var
    
    var happiness: Int = 50
        { // 0 = VERY SAD . 100 = ECSTATIC
        
            didSet
            {
                happiness = min(max(happiness, 0), 100)
                
                print("happiness = \(happiness)")
                
                updateUI()
            }
        }
    
    // TODO: FUNCTION
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
        
    }

 
}
