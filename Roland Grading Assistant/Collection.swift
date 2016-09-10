//
//  Collection.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 5/5/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class Collection {
    // MARK: Properties
    var answers = [Character]()
    init(){
        
    }
    
    func getAnswerCount() -> Int {
        return answers.count
    }
}