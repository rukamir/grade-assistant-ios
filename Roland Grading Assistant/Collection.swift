//
//  Collection.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 5/5/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

struct CollectionKey {
    static let nameKey = "name"
    static let answersKey = "answers"
}

class Collection { //: NSObject, NSCoding {
    // MARK: Properties
    var name: String
    var answers = [String]()
    
    init() {
        answers = []
        name = ""
    }
    
    init(name: String, answers: [String]){
        self.name = name
        self.answers = answers
        //super.init()
    }
    
    func getAnswerCount() -> Int {
        return answers.count
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: CollectionKey.nameKey)
        aCoder.encode(answers, forKey: CollectionKey.answersKey)
    }
    
    /*
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: CollectionKey.nameKey) as! String
        let answers = aDecoder.decodeObject(forKey: CollectionKey.answersKey) as! [String]
        
        //// Because photo is an optional property of Meal, use conditional cast.
        //let ptr = aDecoder.decodeBytes(forKey: CollectionKey.answersKey, returnedLength: &count)
        //let buf = UnsafeBufferPointer<[Character]>(start: ptr, count: &count)
        //answers = [Character](buf)
        
        // Must call designated initializer.
        self.init()
    }
 */
}
