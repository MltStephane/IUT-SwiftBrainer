//
//  Character.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import CoreData




public class Char {
    var username: String
    var gender: String
    var difficulty: String
    var healthPoint: Int
    var damage: Int
    var damageBonus: Int
    var hitChance: Int
    
    init(username: String, gender: String, difficulty: String = "easy", healthPoint: Int = 100, damage: Int = 15, damageBonus: Int = 0, hitChance: Int = 80) {
        self.username = username
        self.gender = gender
        self.difficulty = difficulty
        self.healthPoint = healthPoint
        self.damage = damage
        self.damageBonus = damageBonus
        self.hitChance = hitChance
    }
    
    static func getChar() -> [Char]{
        
        var listCharacters = [Char]()
        
        do {
            let request: NSFetchRequest<Characters> = Characters.fetchRequest()
            let chars = try AppDelegate.viewContext.fetch(request)
            
            for char in chars {
                listCharacters.append(
                    Char(username: char.username ?? "", gender: char.gender ?? "", difficulty: char.difficulty ?? "", healthPoint: 100, damage: 15, damageBonus: 0)
                )
            }
            
        } catch {
            print("Ooups on a pas vraiment reussi a récup les players ...")
        }
        
        return listCharacters
    }
    
    func getGender() -> Int {
        switch "\(self.gender)" {
        case "male":
            return 0
        case "female":
            return 1
        default:
            return 2
        }
    }
    
    func getDifficulty() -> Int {
        switch "\(self.difficulty)" {
        case "easy":
            return 0
        case "medium":
            return 1
        default:
            return 2
        }
    }
}

