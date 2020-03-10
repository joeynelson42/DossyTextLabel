//
//  ViewController.swift
//  DossyTextExample
//
//  Created by Joey Nelson on 3/10/20.
//  Copyright © 2020 nelsonje. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = DossyTextLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for family: String in UIFont.familyNames {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
        }
        
        view.backgroundColor = .white
        
        label.font = UIFont(name: "GreenScreen", size: 24)
        label.delegate = self
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            label.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.type("Goodbye cruel world!")
    }
}

extension ViewController: DossyTextLabelDelegate {
    
}
