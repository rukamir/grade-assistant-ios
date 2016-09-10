//
//  ChoiceData.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 6/7/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class ChoiceData {
    // MARK: Properties
    var allSelections = [Character]()
    var customAnswer: String = ""
   
    init(){
    }
    
    func updateSelection(place: Int, selection: Character) {
        let trueIndex: Int = (place - 1)
        
        if allSelections.count < trueIndex - 1 {
            allSelections[trueIndex] = selection
        } else {
            allSelections.insert(selection, atIndex: trueIndex)
        }
    }
    
    func getSelection(place: Int)-> Character {
        return allSelections[place]
    }
}
