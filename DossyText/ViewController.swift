//
//  ViewController.swift
//  DossyText
//
//  Created by Joey Nelson on 7/9/17.
//  Copyright © 2017 NelsonJE. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DossyTextLabelDelegate {
    
    let baseView = View()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView
        baseView.blink.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        baseView.blink.type("Hello world!\nHow are you today?")
    }
}
