//
//  ProgressView.swift
//  VerticalProgressSwift3
//
//  Created by Vamshi Krishna on 19/04/17.
//  Copyright © 2017 VamshiKrishna. All rights reserved.
//

import UIKit

class ProgressView: UIView {

    var percentDone: CGFloat = 0.0
    override func draw(_ rect: CGRect) {
        let upperRect = CGRect(x: CGFloat(rect.origin.x), y: CGFloat(rect.origin.y), width: CGFloat(rect.size.width), height: CGFloat(rect.size.height * percentDone))
        let lowerRect = CGRect(x: CGFloat(rect.origin.x), y: CGFloat(rect.origin.y + (rect.size.height * percentDone)), width: CGFloat(rect.size.width), height: CGFloat(rect.size.height * (1 - percentDone)))
        
        UIColor.blue.set()
        UIRectFill(upperRect)
        UIColor.white.set()
        UIRectFill(lowerRect)
    }

}
