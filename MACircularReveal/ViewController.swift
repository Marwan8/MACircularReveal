//
//  ViewController.swift
//  MACircularReveal
//
//  Created by Marwan on 12/2/17.
//  Copyright © 2017 Marwan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var circleButton: UIButton!
    @IBOutlet var subView: UIView!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        
        MACirculerReveal.circularReveal(subView, on: view, from: circleButton, completion: nil)
        circleButton.isHidden = true
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        MACirculerReveal.circularUnReveal(subView, from: view , to: circleButton , completion: nil)
        circleButton.isHidden = false
    }
}
