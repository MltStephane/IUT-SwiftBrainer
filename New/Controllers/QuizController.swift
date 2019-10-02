//
//  QuizController.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import UIKit


class QuizController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultatLabel: UILabel!
    @IBOutlet weak var resultatButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var leaveButton: UIButton!
    @IBOutlet weak var goFightButton: UIButton!
    
    @IBOutlet weak var questionCountLabel: UILabel!
    
    
    var quiz = Quiz(question: "", answer: "")
    var player = Char.getChar()[Char.getChar().count-1]
    var speciality = ["9", "10", "11", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "26", "27", "28", "29", "30", "31", "32"]
    
    
    var questionMax: Int = 5
    var questionGoal: Int = 3
    var questionCount: Int = 0
    var questionRight: Int = 0
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.start(Restart: true)
    }
    
    
    func start(Restart: Bool) {
        self.goFightButton.isHidden = true
        self.resultatLabel.isHidden = true
        self.resultatButton.isHidden = true
        
        _ = QuizManager.getRandomQuizz(speciality: speciality[Int.random(in: 0...speciality.count-1)], difficulty: "medium").done {
            (quiz) in
            if(self.questionCount != self.questionMax){
                if(Restart == true) {
                    self.questionCount = 1
                    self.questionRight = 0
                    
                    switch self.player.difficulty {
                    case "easy":
                        self.questionMax = 5
                        self.questionGoal = 4
                    case "medium":
                        self.questionMax = 7
                        self.questionGoal = 5
                    case "hard":
                        self.questionMax = 10
                        self.questionGoal = 9
                        
                    default:
                        self.questionMax = 5
                        self.questionGoal = 4
                    }
                } else {
                    self.questionCount += 1
                }
                self.goFightButton.isHidden = true
                self.trueButton.isHidden = false
                self.falseButton.isHidden = false
                self.quiz.question = "\n\(quiz.question)\n"
                self.quiz.answer = quiz.answer
                self.questionCountLabel.text = "\(self.questionCount)/\(self.questionMax)"
                self.questionLabel.text = self.quiz.question.stringByDecodingHTMLEntities
            } else {
                
            }
        }
    }
    
    @IBAction func trueButtonAction(_ sender: Any) {
        
        if(self.questionCount == self.questionMax) {
            self.verifWin()
            
            uiStateFight()
        } else {
            if self.quiz.answer == "True" {
                self.resultatLabel.text = "Right answer!"
                self.questionRight += 1
            } else {
                self.resultatLabel.text = "Wrong answer."
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.start(Restart: false)
            }
            uiStatePlay()
        }
        
    }
    
    @IBAction func falseButtonAction(_ sender: Any) {
        
        if(self.questionCount == self.questionMax) {
            
            uiStateFight()
            self.verifWin()
        } else {
            if self.quiz.answer == "False" {
                self.resultatLabel.text = "Right answer!"
                self.questionRight += 1
            } else {
                self.resultatLabel.text = "Wrong answer."
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                self.start(Restart: false)
            }
            uiStatePlay()
        }
        
    }
    
    func uiStateFight() {
        self.goFightButton.isHidden = false
        self.leaveButton.isHidden = false
        self.trueButton.isHidden = true
        self.falseButton.isHidden = true
        self.resultatLabel.isHidden = false
        self.resultatButton.isHidden = true
    }
    func uiStatePlay() {
        self.leaveButton.isHidden = false
        self.trueButton.isHidden = true
        self.falseButton.isHidden = true
        self.resultatLabel.isHidden = false
        self.resultatButton.isHidden = false
    }
    func verifWin() {
        if(self.questionRight < self.questionGoal) {
            self.resultatLabel.text = "Loser."
            self.resultatButton.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true)
            }
        } else {
            self.resultatLabel.text = "You won!"
        }
    }
    @IBAction func nextQuestionButtonAction(_ sender: Any) {
        self.start(Restart: false)
    }
    
    @IBAction func leaveButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func goFightButtonAction(_ sender: Any) {
    }
}

