//
//  FightController.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//


import Foundation
import UIKit


class FightController: UIViewController {
    

    var player = Char.getChar()[Char.getChar().count-1]
   var enemy = Char(username: "TomDoe", gender: "male", difficulty: "medium", healthPoint: 100, damage: 15, damageBonus: 1, hitChance: 70)
    @IBOutlet weak var enemyImage: UIWebView!
    @IBOutlet weak var enemyName: UILabel!
    @IBOutlet weak var enemyHP: UILabel!
    
    @IBOutlet weak var playerImage: UIWebView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerHP: UILabel!
    
    @IBOutlet weak var attackButton: UIButton!
    @IBOutlet weak var vsText: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var winButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    func start() {
        switch player.difficulty {
        case "easy":
            enemy.healthPoint = 100
            enemy.damage = 15
            enemy.hitChance = 70
        case "medium":
            enemy.healthPoint = 150
            enemy.damage = 15
            enemy.hitChance = 65
        case "hard":
            enemy.healthPoint = 200
            enemy.damage = 15
            enemy.hitChance = 65
        default:
            enemy.healthPoint = 100
            enemy.damage = 15
            enemy.hitChance = 70
        }
        self.winLabel.isHidden = true
        self.winButton.isHidden = true
        self.vsText.text = "\(enemy.username) vs \(player.username)"
        self.rewriteHP()
        
        print(self.player.gender)
        print(self.player.username)
        self.playerName.text = self.player.username
        self.playerImage.loadRequest(URLRequest(url: URL(string:
            "https://avatars.dicebear.com/v2/\(self.player.gender)/\(self.player.username).svg")!))
        
        self.enemyName.text = self.enemy.username
        self.enemyImage.loadRequest(URLRequest(url: URL(string:
            "https://avatars.dicebear.com/v2/\(self.enemy.gender)/\(self.enemy.username).svg")!))
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
    }
    
    @IBAction func attackButtonAction(_ sender: Any) {
        self.player.healthPoint -= Int.random(in: 0...self.enemy.damage)
        self.enemy.healthPoint -= Int.random(in: 0...self.player.damage)
        
        self.rewriteHP()
        self.testWin()
    }
    
    
    func rewriteHP() {
        self.enemyHP.text = "\(self.enemy.healthPoint) HP"
        self.playerHP.text = "\(self.player.healthPoint) HP"
    }
    
    func testWin() {
        if(self.player.healthPoint <= 0) {
            self.winLabel.text = "\(self.enemy.username) won."
            self.attackButton.isHidden = true
            self.winLabel.isHidden = false
            self.winButton.isHidden = false
        } else if(self.enemy.healthPoint <= 0) {
            self.winLabel.text = "You won."
            self.attackButton.isHidden = true
            self.winLabel.isHidden = false
            self.winButton.isHidden = false
        } else if(self.enemy.healthPoint <= 0 && self.player.healthPoint <= 0) {
            self.winLabel.text = "Nobody won."
            self.attackButton.isHidden = true
            self.winLabel.isHidden = false
            self.winButton.isHidden = false
        }
    }
}

