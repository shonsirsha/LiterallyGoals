//
//  UIButtonExt.swift
//  goalpost-app
//
//  Created by Caleb Stultz on 7/31/17.
//  Copyright © 2017 Caleb Stultz. All rights reserved.
//

import UIKit

extension UIButton {
    func setSelectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.3279390114, green: 0.6726223166, blue: 0.9525499683, alpha: 1)
    }
    
    func setDeselectedColor() {
        self.backgroundColor = #colorLiteral(red: 0.8543781726, green: 0.8543781726, blue: 0.8543781726, alpha: 1)
    }
}
