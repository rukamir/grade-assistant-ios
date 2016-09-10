//
//  AnswerInputViewController.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 9/8/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class AnswerInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {
    // MARK: Properties
    @IBOutlet var answerSelector: MultiChoiceController!
    @IBOutlet var questionSelector: UIPickerView!
    
    var answerChoices = [String]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Set up Question selector picker object
        self.questionSelector.delegate = self
        self.questionSelector.dataSource = self
        answerChoices = ["a", "g","b","a","j","c","h","d","a","j","e"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Input answers
    @IBAction func inputAnswerSelection(sender: UITapGestureRecognizer) {
        print("touched")
    }
    
    // MARK: Picker Controls
    // What items are in picker
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if answerChoices.count-1 < row {
            return "Next " + String(row+1)
        } else {
            return String(row+1)
        }

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // How many rows are in picker
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerChoices.count+1
    }
    
    // When new item is picked
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("picked"+String(row))
        self.answerSelector.setSelected(answerChoices[row])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
