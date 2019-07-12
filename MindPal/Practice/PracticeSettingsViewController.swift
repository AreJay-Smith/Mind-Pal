//
//  PracticeSettingsViewController.swift
//  MindPal
//
//  Created by Randall Smith on 7/8/19.
//  Copyright © 2019 Randall Smith. All rights reserved.
//

import UIKit

class PracticeSettingsViewController: UIViewController {

    @IBOutlet weak var numCardsView: UITextField!
    @IBOutlet weak var numMinutesView: UITextField!
    var numCards = 0
    var numMinutes = 0
    
    @IBOutlet weak var minutesNumView: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numCardsView.delegate = self
        numMinutesView.delegate = self
        
        
//        minutesNumView.sizeToFit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numCardsView.resignFirstResponder()
        numMinutesView.resignFirstResponder()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "goToPracticeScreen" {
            numCards = Int(numCardsView.text ?? "0") ?? 0
            numMinutes = Int(numMinutesView.text ?? "0") ?? 0
            
            if numCards > 0 && numMinutes > 0  {
                return true
            } else {
                let controller = UIAlertController(title: "Invalid Entry", message: "Please enter valid numbers!", preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(controller, animated: true, completion: nil)
                return false
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPracticeScreen" {
            
            if let practiceViewController = segue.destination as? PracticeViewController {
                practiceViewController.numCards = self.numCards
                practiceViewController.numMinutes = self.numMinutes
            }
        }
    }
}

extension UIViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
