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
    
    var player : Char = Char.getChar()[Int.random(in: 0...Char.getChar().count-1)]
    var enemy = Char(username: "Tom Doe", gender: "male", difficulty: "medium", healthPoint: 100, damage: 15, damageBonus: 1, hitChance: 70)
   
    @IBOutlet weak var enemyImage: UIWebView!
    @IBOutlet weak var enemyHP: UILabel!
    
    @IBOutlet weak var playerImage: UIWebView!
    @IBOutlet weak var playerHP: UILabel!
    
    @IBOutlet weak var vsText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start()
    }
    
    func start() {
        self.vsText.text = "\(enemy.username) vs \(player.username)"
        self.rewriteHP()
        self.enemyImage.loadRequest(URLRequest(url: URL(string: "https://avatars.dicebear.com/v2/\(self.player.gender)/\(self.player.username).svg")!))
        self.enemyImage.loadRequest(URLRequest(url: URL(string: "https://avatars.dicebear.com/v2/male/\(Int.random(in: 1...999)).svg")!))
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated:  true)
    }
    
    @IBAction func attackButtonAction(_ sender: Any) {
    }
    
    
    func rewriteHP() {
        self.enemyHP.text = "\(self.enemy.healthPoint) HP"
        self.playerHP.text = "\(self.player.healthPoint) HP"
    }
}

