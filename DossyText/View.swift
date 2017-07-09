//
//  View.swift
//  DossyText
//
//  Created by Joey Nelson on 7/9/17.
//  Copyright © 2017 NelsonJE. All rights reserved.
//

import Foundation
//
//  BaseView.swift
//

import UIKit

class View: UIView {
    
    // MARK: - Properties
    
    // MARK: - Subviews
    var blink: DossyTextLabel!
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(frame: .zero)
        configureSubviews()
        configureLayout()
    }
    
    /// Set view/subviews appearances
    fileprivate func configureSubviews() {
        backgroundColor = UIColor.fromHex(rgbValue: 0x181818)
        
        blink = DossyTextLabel()
        blink.textColor = UIColor.fromHex(rgbValue: 0x1DB954)
        blink.numberOfLines = 0
    }
    
    /// Add subviews, set layoutMargins, initialize stored constraints, set layout priorities, activate constraints
    fileprivate func configureLayout() {
        
        addSubview(blink)
        blink.translatesAutoresizingMaskIntoConstraints = false
        
        // Activate NSLayoutAnchors within this closure
        NSLayoutConstraint.activate([
            blink.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            blink.leftAnchor.constraint(equalTo: leftAnchor, constant: 25),
            blink.rightAnchor.constraint(equalTo: rightAnchor, constant: -25)
            ])
    }
}

extension UIColor{
    class func fromHex(rgbValue:UInt32, alpha:Double=1.0) -> UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
