//
//  TriviaQuiestion.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation


struct CategoryJSON: Codable {
    var trivia_categories: [Category]
}

struct Category: Codable {
    var id: Int // 9,
    var name: String // "General Knowledge"
}


struct TokenJSON: Codable {
    var response_code: Int
    var response_message: String?
    var token: String
}

struct QuestionJSON: Codable {
    var response_code: Int
    var results: [Question]
}

struct Question: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}



enum JSONResponseCodes: Int  {
    case Success = 0
    case NoResult = 1 // The API doesn't have enough questions for your query. (Ex. Asking for 50 Questions in a Category that only has 20.)
    case InvalidParameter = 2
    case TokenNotFound = 3
    case TokenEmpty = 4
}

enum QuestionDifficulty: String {
    case easy, medium, hard
}


enum QuestionType: String {
    case all, multiple, boolean
}

enum QuestionEncoding: String {
    case html // Don&‌#039;t forget that &‌pi; = 3.14 &‌amp; doesn&‌#039;t equal 3.
    case base64 // RG9uJ3QgZm9yZ2V0IHRoYXQgz4AgPSAzLjE0ICYgZG9lc24ndCBlcXVhbCAzLg==
    case url3986 // Don%27t%20forget%20that%20%CF%80%20%3D%203.14%20%26%20doesn%27t%20equal%203.
    case urlLegacy //Don%27t+forget+that+%CF%80+%3D+3.14+%26+doesn%27t+equal+3.
}


enum CategoryName: String, CaseIterable {
    case General
    case Books
    case Film
    case Music
    case Theatre
    case Television
    case VideoGames = "Video Games"
    case BoardGames = "Board Games"
    case Nature
    case Computers
    case Math
    case Mythology
    case Sports
    case Geography
    case History
    case Politics
    case Art
    case Celebrities
    case Animals
    case Vehicles
    case Comics
    case Gadgets
    case Anime
    case Cartoon
    
    static func toCategoryInt(categoryName: CategoryName) -> Int {
        switch categoryName {
        case .General: return 9
        case .Books: return 10
        case .Film: return 11
        case .Music: return 12
        case .Theatre: return  13
        case .Television: return 14
        case .VideoGames: return 15
        case .BoardGames: return 16
        case .Nature: return 17
        case .Computers: return 18
        case .Math: return 19
        case .Mythology: return 20
        case .Sports: return 21
        case .Geography: return 22
        case .History: return 23
        case .Politics: return 24
        case .Art: return 25
        case .Celebrities : return 26
        case .Animals: return 27
        case .Vehicles: return 28
        case .Comics: return 29
        case .Gadgets: return 30
        case .Anime: return 31
        case .Cartoon: return 32
        }
    }
    
    static func toCategoryName(categoryString: String) -> CategoryName {
        switch categoryString {
        case "General Knowledge": return .General
        case "Entertainment: Books": return .Books
        case "Entertainment: Film": return .Film
        case "Entertainment: Music": return .Music
        case "Entertainment: Musicals & Theatres": return .Theatre
        case "Entertainment: Television": return .Television
        case "Entertainment: Video Games": return .VideoGames
        case "Entertainment: Board Games": return .BoardGames
        case "Science & Nature": return .Nature
        case "Science: Computers": return .Computers
        case "Science: Mathematics": return .Math
        case "Mythology": return .Mythology
        case "Sports": return .Sports
        case "Geography": return .Geography
        case "History": return .History
        case "Politics": return .Politics
        case "Art": return .Art
        case "Celebrities": return .Celebrities
        case "Animals": return .Animals
        case "Vehicles": return .Vehicles
        case "Entertainment: Comics": return .Comics
        case "Science: Gadgets": return .Gadgets
        case "Entertainment: Japanese Anime & Manga": return .Anime
        case "Entertainment: Cartoon & Animations": return .Cartoon
        default: return .General
        }
    }
    
    static func toImageName(categoryName: CategoryName) -> String {
        switch categoryName{
        case .VideoGames: return "VideoGames"
        case .BoardGames: return "BoardGames"
        default: return categoryName.rawValue
        }
    }
    
}
