//
//  TriviaAPIService.swift
//  Trivia
//
//  Created by Winston Maragh on 9/22/18.
//  Copyright © 2018 Winston Maragh. All rights reserved.
//

import Foundation
import Alamofire



struct TriviaEndpoints {
    static let baseURL = "https://opentdb.com/api.php?amount=20"
    let categoriesEndpoint = "https://opentdb.com/api_category.php"
    //    var categoryCountEndpoint = "https://opentdb.com/api_count.php?category=\(categoryID)"
    
    
    var numOfQuestions: Int
    var category: String
    var difficulty: String //easy, medium, hard
    var type: String //multiple, boolean,
    
    static var triviaToken: String? = "2231f4ded7c417ddf45726835971d0c550900f4da24900258a74d8312879195c"

    //create params
    
}


class TriviaAPIService {
    private init(){}
    static let shared = TriviaAPIService()
    
    
    public func getCagtegories(completion: @escaping ([CategoryName]) -> Void){
        let categoriesEndpoint = "https://opentdb.com/api_category.php"
        Alamofire.request(categoriesEndpoint).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(CategoryJSON.self, from: data)
                        let categories = JSON.trivia_categories.map { CategoryName.toCategoryName(categoryString: $0.name) }
                        completion(categories)
                    }
                    catch {print("Error processing data. Error: \(error)")}
                }
            } else {
                print("Error\(String(describing: response.result.error))")
            }
        }
        
    }
    
    
    public func getQuestions(numOfQuestions: Int?, categoryName: CategoryName?, difficulty: QuestionDifficulty?, type: QuestionType?, encoding: QuestionEncoding?, completion: @escaping ([Question]?) -> Void) {
        
        var url = TriviaEndpoints.baseURL
        
//        if let token = TriviaEndpoints.triviaToken {
//            url += "&token=\(token)"
//        }

//        if let unwrappedNumOfQuestions = numOfQuestions {
//            url += "amount=\(unwrappedNumOfQuestions)"
//        }
//
//        if let categoryName = categoryName {
//            let categoryID = CategoryName.toCategoryInt(categoryName: categoryName)
//            url += "&category=\(categoryID)"
//        }
//
//        if let unwrappedDifficulty = difficulty {
//            url += "&difficulty=\(unwrappedDifficulty)"
//        }
//
//        if let unwrappedEncoding = encoding {
//            url += "&encode=\(unwrappedEncoding)"
//        }
        
        
        Alamofire.request(url).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(QuestionJSON.self, from: data)
                        
                        switch JSON.response_code {
                        case JSONResponseCodes.Success.rawValue:
                            let questions = JSON.results
                            completion(questions)
                        case JSONResponseCodes.NoResult.rawValue:
                            // change the numOfQuestions
                            print(JSONResponseCodes.NoResult.rawValue)
                            completion(nil)
//                            getQuestions(numOfQuestions: 20, category: category, difficulty: difficulty, type: type, encoding: encoding, completion: { (<#[Question]?#>) in
//                                <#code#>
//                            })
                        case JSONResponseCodes.InvalidParameter.rawValue:
                            print(JSONResponseCodes.InvalidParameter)
                            completion(nil)
                        case JSONResponseCodes.TokenEmpty.rawValue:
                            //reset token
                            print(JSONResponseCodes.TokenEmpty)
                            completion(nil)
                        case JSONResponseCodes.TokenNotFound.rawValue:
                            //get token
                            print(JSONResponseCodes.TokenNotFound)
                            completion(nil)
                        default:
                            completion(nil)
                        }
                    }
                    catch {print("Error processing data. Error: \(error)")}
                }
            } else {
                print("Error\(String(describing: response.result.error))")
            }
        }
        
        
    }
    
    func retrieveToken(completion: @escaping (String) -> Void) {
        let requestURL = "https://opentdb.com/api_token.php?command=request"
        Alamofire.request(requestURL).responseJSON { (response) in
            if response.result.isSuccess {
                if let data = response.data {
                    do {
                        let JSON = try JSONDecoder().decode(TokenJSON.self, from: data)
                        let token = JSON.token
                        completion(token)
                    }
                    catch {print("Error processing data. Error: \(error)")}
                }
            } else {
                print("Error\(String(describing: response.result.error))")
            }
        }
        
    }
    
//    func resetToken(token: String) {
//        var tokenURL = "https://opentdb.com/api_token.php?command=reset&token=\(token)"
//        Alamofire.request(requestURL).responseJSON { (response) in
//            if response.result.isSuccess {
//                if let data = response.data {
//                    do {
//                        let JSON = try JSONDecoder().decode(TriviaTokenResponse.self, from: data)
//                        let token = JSON.token
//
//                        completion(token)
//                    }
//                    catch {print("Error processing data. Error: \(error)")}
//                }
//            } else {
//                print("Error\(String(describing: response.result.error))")
//            }
//        }
//    }
    
}

