//
//  ViewController.swift
//  Animation Test
//
//  Created by Sam Dillin on 8/13/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import Foundation
import UIKit

class StartingPointViewController: UIViewController{
    
    func giveView() -> UIView{
        
       return self.view!
    }
    
    override func viewDidLoad() {
        
            let hold = StartingPointView()
        hold.anything()
        self.view = hold
    }
}
