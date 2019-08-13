//
//  View.swift
//  Animation Test
//
//  Created by Sam Dillin on 8/13/19.
//  Copyright © 2019 Sam Dillin. All rights reserved.
//

import Foundation
import UIKit

class StartingPointView: UIView{
    
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Buttom: UIButton!
    
    
    func anything(){
        let rect = CGRect(x:0, y:0, width: 1000, height: 1000)
        self.frame = rect
        self.backgroundColor = .white
        
        var thisLabel = UILabel()
        thisLabel.backgroundColor = .black
        thisLabel.frame = CGRect(x: 0, y: 100, width: 100, height: 100)
        var thisButton = UIButton()
        thisButton.backgroundColor = .black
        
        self.addSubview(thisLabel)
        self.addSubview(thisButton)
    }
}
