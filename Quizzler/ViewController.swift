//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // all the questions data goes here
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    
    var questionNumber: Int = 0
    var score: Int = 0
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // when the view is loaded we display the first question
        
        // get the first question from the data bank
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        // the user pressed either the true or false button
        
        // we check which button was pressed
        if sender.tag == 1 {
            pickedAnswer = true
        }
        else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        checkAnswer()
        
        questionNumber += 1
        
        nextQuestion()
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / 13"
        
        // we divede the width of the screen by 13
        progressWidth.constant = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)
    }
    

    func nextQuestion() {
        if questionNumber <= 12 {
            questionLabel.text = allQuestions.list[questionNumber].questionText
            updateUI()
        }
        else {
            let alert = UIAlertController(
                title: "Awesome",
                message: "You finished all the questions, do you want to start over?",
                preferredStyle: .alert)
            
            let restartAction = UIAlertAction(
                title: "Restart",
                style: .default) { (UIAlertAction) in
                    self.startOver()
            }
            
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
            
        }

    }
    
    
    func checkAnswer() {
        // check if the answer the user picked is the correct answer
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score += 1
        }
        else {
            ProgressHUD.showError("Wrong!")
        }
    }
    
    
    func startOver() {
       
        questionNumber = 0
        score = 0
        
        nextQuestion()
    }
    

    
}
