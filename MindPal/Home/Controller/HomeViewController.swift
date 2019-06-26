//
//  ViewController.swift
//  MindPal
//
//  Created by Randall Smith on 6/19/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var lessonsBtn: UIButton!
    @IBOutlet weak var practiceBtn: UIButton!
    @IBOutlet weak var testBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lessonsBtn.layer.cornerRadius = 15
        practiceBtn.layer.cornerRadius = 15
        testBtn.layer.cornerRadius = 15
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
}

