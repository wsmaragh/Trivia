//
//  Extensions.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//



import UIKit



extension UIColor {
        
    static var randomColor: UIColor {
        let red = CGFloat.random(in: 0...1)
        let green = CGFloat.random(in: 0...1)
        let blue = CGFloat.random(in: 0...1)
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
}



