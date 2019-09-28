//
//  Settings.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import UIKit


class SettingsController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func getGender() -> String {
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            return "male"
        case 1:
            return "female"
        default:
            return "bottts"
        }
    }
    
    private func getDifficulty() -> String {
        switch difficultySegmentedControl.selectedSegmentIndex {
        case 0:
            return "easy"
        case 1:
            return "medium"
        case 2:
            return "hard"
        default:
            return "easy"
        }
    }
    
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        let player = Characters(context: AppDelegate.viewContext)
        
        player.username = self.usernameTextField.text ?? ""
        player.gender = self.getGender()
        player.difficulty = self.getDifficulty()
        
        do {
            try AppDelegate.viewContext.save()
            self.dismiss(animated: true)
            print("save Ok")
        }catch {
            print("oups fail")
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


