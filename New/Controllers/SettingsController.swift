//
//  Settings.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SettingsController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var difficultySegmentedControl: UISegmentedControl!
    
    
    var player: Char = Char(username: "Bobby", gender: "female")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.start()
        
    }
    
    private func getScGender() -> String {
        switch genderSegmentedControl.selectedSegmentIndex {
        case 0:
            return "male"
        case 1:
            return "female"
        default:
            return "bottts"
        }
    }
    func start() {
        if(Char.getChar().count == 0) {
            player = Char(username: "Bobby", gender: "female")
        } else {
            player = Char.getChar()[0]
        }
        for i in Char.getChar() {
            print(i.username)
        }
        
        usernameTextField.text = player.username
        genderSegmentedControl.selectedSegmentIndex = player.getGender()
        difficultySegmentedControl.selectedSegmentIndex = player.getDifficulty()
        
    }
    private func getScDifficulty() -> String {
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
        
//            let charSave = Characters(context: AppDelegate.viewContext)
//
//            charSave.username = self.usernameTextField.text ?? ""
//            charSave.gender = self.getScGender()
//            charSave.difficulty = self.getScDifficulty()
//
//            do {
//                try AppDelegate.viewContext.save()
//                self.dismiss(animated: true)
//                print("save Ok")
//            }catch {
//                print("oups fail")
//            }
    
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Characters")
        
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedContext = appDelegate.persistentContainer.viewContext
            let results = try AppDelegate.viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned
                results?[0].setValue("\(self.usernameTextField.text ?? "Bobby")", forKey: "username")
                results?[0].setValue("\(self.getScGender())", forKey: "gender")
                results?[0].setValue("\(self.getScDifficulty())", forKey: "difficulty")
                do {
                    try managedContext.save()
                    self.dismiss(animated: true)
                }catch {
                    print("oups fail")
                }
            } else {
                let charSave = Characters(context: AppDelegate.viewContext)
                
                charSave.username = self.usernameTextField.text ?? ""
                charSave.gender = self.getScGender()
                charSave.difficulty = self.getScDifficulty()
    
                do {
                    try AppDelegate.viewContext.save()
                    self.dismiss(animated: true)
                    print("save Ok")
                }catch {
                    print("oups fail")
                }
            }
        } catch {
            print("Fetch Failed: (error)")
        }
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


