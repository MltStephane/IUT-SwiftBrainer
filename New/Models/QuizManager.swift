//
//  QuizManager.swift
//  New
//
//  Created by Stephane Mulot on 27/09/2019.
//  Copyright © 2019 Stephane Mulot. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


class Quiz {
    var question: String
    var answer: String
    
    init(question: String, answer:String) {
        self.question = question
        self.answer = answer
    }
    
}


struct QuizApi: Codable {
    struct Result: Codable {
        var question: String?
        var correct_answer: String?
        
    }
    var results: [Result]
}


class QuizManager {
    
    
    //    ["id":9, "name":"General knowledge"],
    //    ["id":12, "name":"Music"],
    //    ["id":11, "name":"Film"],
    //    ["id":15, "name":"Video games"],
    //    ["id":31, "name":"Anime & Manga"],
    
    static func getRandomQuizz(speciality: String, difficulty: String) -> Promise<Quiz>{
        
        return Promise { seal in
            Alamofire.request("https://opentdb.com/api.php?amount=1&category=\(speciality)&difficulty=\(difficulty)&type=boolean").response{
                response in
                
                guard let data = response.data else {return}
                
                do {
                    let decoder = JSONDecoder()
                    let quizApi = try decoder.decode(QuizApi.self, from: data)
                    print(quizApi)
                    if quizApi.results.count != 0 {
                        if let question = quizApi.results[0].question, let answer = quizApi.results[0].correct_answer {
                            seal.fulfill(Quiz(question: question, answer: answer))
                        } else {
                            seal.reject(NSError(domain: "Error1", code: 1, userInfo: nil))
                        }
                    } else {
                        self.getRandomQuizz(speciality: "9", difficulty: "medium")
                    }
                } catch _ {
                    seal.reject(NSError(domain: "Error2", code: 2, userInfo: nil))
                }
            }
        }
    }
}


