//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var pickedAnswer : Bool = false
    var questionNumber : Int = 0
    var currentScore : Int = 0
    var progressBarSize : CGFloat = 0.0
    
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBarTotalLength: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //could I use arc4random with limit to pick a random question here? It would have to keep track of used questions.
        
    
        nextQuestion()
        
       
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        questionNumber += 1
       // progressBarSize += (progressBarTotalLength.frame.size.width / CGFloat(13 * questionNumber))
        nextQuestion()
            
    }
    
    
    func updateUI() {
        questionLabel.text = allQuestions.list[questionNumber].questionText
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        scoreLabel.text = "Score: \(currentScore)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count)) * CGFloat(questionNumber + 1)
        
    }
    

    func nextQuestion() {
        
        if questionNumber <= (allQuestions.list.count-1) {
           updateUI()
        } else {
            let alert = UIAlertController(title: "End of Quiz", message: "Do you want to start over?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if pickedAnswer == correctAnswer {
            print("you got it!")
            currentScore += 1
            
            
        } else {
            print("wrong")
        }
        
        
    }
    
    
    func startOver() {
        questionNumber = 0
        progressBarSize = 0.0
        currentScore = 0
        nextQuestion()
    }
    

    
}
