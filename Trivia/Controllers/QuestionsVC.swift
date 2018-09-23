//
//  QuestionsVC.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class QuestionsVC: UIViewController {

    @IBOutlet weak var questionsCollectionView: UICollectionView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categoryName: CategoryName!
    
    var questions = [Question]()
    {
        didSet {
            self.questions.shuffle()
            self.currentQuestion = questions[0]
            self.questionsCollectionView.reloadData()
        }
    }
    
    var currentQuestion: Question! {
        didSet {
            print("current Question is set to \(currentQuestion)")
            
        }
    }
    
    var choices: [String] = [] {
        didSet {
            self.choices.shuffle()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuestions()
        setupCollectionView(collectionView: questionsCollectionView)
        if let categoryName = categoryName {
            categoryLabel.text = categoryName.rawValue
        }
    }
    
    private func setupCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchQuestions(){
        TriviaAPIService.shared.getQuestions(numOfQuestions: 10, categoryName: categoryName, difficulty: QuestionDifficulty.easy, type: QuestionType.multiple, encoding: QuestionEncoding.html) { (onlineTriviaQuestions) in
            if let triviaQuestions = onlineTriviaQuestions {
                self.questions = triviaQuestions
            }
        }
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//    }

}



// MARK:- CollectionView Setup
extension QuestionsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionCell.id, for: indexPath) as! QuestionCell
        let question = questions[indexPath.row]
        cell.configureCell(question: question)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

