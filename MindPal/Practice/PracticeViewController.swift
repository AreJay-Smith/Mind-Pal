//
//  PracticeViewController.swift
//  MindPal
//
//  Created by Randall Smith on 7/8/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController {
    
    var numCards = 0
    var numMinutes = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print(numCards)
        print(numMinutes)
        // Do any additional setup after loading the view.
        self.navigationController?.viewControllers.remove(at: 1)
    }
}
