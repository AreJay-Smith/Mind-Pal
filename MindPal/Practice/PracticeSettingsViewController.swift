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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        numCardsView.delegate = self
        numMinutesView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        numCardsView.resignFirstResponder()
        numMinutesView.resignFirstResponder()
    }
    
    @IBAction func beginPracticePressed(_ sender: Any) {
        
        numCards = Int(numCardsView.text!)!
        numMinutes = Int(numMinutesView.text!)!
        
        if numCards > 0 && numMinutes > 0  {
            performSegue(withIdentifier: "goToPracticeScreen", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToPracticeScreen" {
            
            let practiceViewController = segue.destination as! PracticeViewController
            
            practiceViewController.numCards = self.numCards
            practiceViewController.numMinutes = self.numMinutes
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController : UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
