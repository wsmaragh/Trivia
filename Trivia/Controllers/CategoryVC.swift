//
//  ViewController.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit


class CategoryVC: UIViewController {

    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var categoryNames: [CategoryName] = [] {
        didSet {
            self.categoryCollectionView.reloadData()
            self.animateCollectionView(collectionView: categoryCollectionView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategories()
        setupCollectionView(collectionView: categoryCollectionView)
    }
    
    private func fetchCategories(){
        TriviaAPIService.shared.getCagtegories { (onlineCategoriesNames) in
            self.categoryNames = onlineCategoriesNames
        }
    }
    
    private func setupCollectionView(collectionView: UICollectionView){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func animateCollectionView(collectionView: UICollectionView) {
        collectionView.reloadData()
        let cells = collectionView.visibleCells
        let collectionViewHeight: CGFloat = collectionView.bounds.size.height
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: collectionViewHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let questionsVC = segue.destination as? QuestionsVC else {return}
        let cell = sender as! UICollectionViewCell
        let indexPath = self.categoryCollectionView.indexPath(for: cell)
        let categoryName = self.categoryNames[indexPath!.item]
        questionsVC.categoryName = categoryName
    }
    
}



// MARK:- CollectionView Setup
extension CategoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        let categoryName = categoryNames[indexPath.row]
        cell.configureCell(categoryName: categoryName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let cellspacing: CGFloat = 10.0
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 5.0
        layout.sectionInset = UIEdgeInsets(top: cellspacing, left: cellspacing, bottom: cellspacing, right: cellspacing)
        let numberOfItemsPerRow: CGFloat = 3.0
        let itemWidth: CGFloat = (collectionView.bounds.width / numberOfItemsPerRow) - cellspacing
        let itemHeight: CGFloat = collectionView.bounds.height / 6.0
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}

