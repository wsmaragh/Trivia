//
//  TriviaCard.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class QuestionCell: UICollectionViewCell {
    
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!

    @IBOutlet weak var choice1: UIButton!
    @IBOutlet weak var choice2: UIButton!
    @IBOutlet weak var choice3: UIButton!
    @IBOutlet weak var choice4: UIButton!
    
    static let id: String = "QuestionCell"
    
    var countdownTimer: Timer!
    var totalTimeInSeconds: Int = 10
    
    var correctAnswer: String = ""
    var choices: [String] = []
    
    @IBAction func choiceTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1: print("1")
        case 2: print("2")
        case 3: print("3")
        case 4: print("4")
        default: break
        }
        
    }

    
    public func configureCell(question: Question){
        self.difficultyLabel.text = question.difficulty
        switch question.difficulty {
        case "easy": difficultyLabel.backgroundColor = UIColor.green
        case "medium": difficultyLabel.backgroundColor = UIColor.yellow
        case "hard": difficultyLabel.backgroundColor = UIColor.red
        default: difficultyLabel.backgroundColor = UIColor.green
        }
        self.questionLabel.text = question.question
        self.choices = question.incorrect_answers
        self.choices.append(question.correct_answer)
        
        if question.type == QuestionType.boolean.rawValue {
            choice1.setTitle(choices[0], for: .normal)
            choice2.setTitle(choices[1], for: .normal)
            choice3.isHidden = true
            choice4.isHidden = true
        } else if question.type == QuestionType.multiple.rawValue {
            choice3.isHidden = false
            choice4.isHidden = false
            choice1.setTitle(choices[0], for: .normal)
            choice2.setTitle(choices[1], for: .normal)
            choice3.setTitle(choices[2], for: .normal)
            choice4.setTitle(choices[3], for: .normal)
        }

        startTimer()
    }
    
    
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        countdownLabel.text = "\(timeFormatted(totalTimeInSeconds))"
        totalTimeInSeconds != 0 ? totalTimeInSeconds -= 1 : endTimer()
    }
    
    func endTimer() {
        //play sound
        countdownTimer.invalidate()
    }

    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        return String(format: "%02d", seconds)
    }
    
    func nextQuestion(){
        
    }
    
}

