//
//  CategoryCell.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    static let id: String = "CategoryCell"
    
    func configureCell(categoryName: CategoryName){
        categoryLabel.text = categoryName.rawValue
        categoryImageView.image = UIImage(named: CategoryName.toImageName(categoryName: categoryName))
        
        #warning("change implementation to be outside the configureCell")
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = 6;
        self.backgroundColor = UIColor.randomColor;
    }
    
}
