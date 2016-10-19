//
//  AnswerInputViewController.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 9/8/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class AnswerInputViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate, UINavigationControllerDelegate  {
    // MARK: Properties
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var answerSelector: MultiChoiceController!
    @IBOutlet var questionSelector: UIPickerView!
    @IBOutlet weak var navBarTitle: UIButton!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var largeFrame: UIView!
    @IBOutlet weak var stackView: UIStackView!
    //@IBOutlet weak var stackView: UIStackView!
    
    // to be passed back and forth
    var collection: Collection
    
    var answerChoices = [String]()
    var name: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        collection = Collection()
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if !(collection.name == "") {
            self.navBarTitle.setTitle(collection.name, for: .normal)
            if !(answerChoices[0] == "") {
                self.answerSelector.setSelected(answerChoices[0])
            }
        }
        
        //let posX = stackView.layer.position.x
        //let posY = stackView.layer.position.y
        //largeFrame.layer.frame = CGRect(x: 100, y: 100, width: 300, height: 300)
        
        //largeFrame.layer.frame = CGRect()
        //largeFrame.layer.position.x = 100
        //largeFrame.layer.position.y = 100
        //largeFrame.layer.frame.size.width = CGFloat(350)
        //largeFrame.layer.frame.size.height = CGFloat(500)
        largeFrame.layer.shadowRadius = 10.0
        largeFrame.layer.cornerRadius = 15.0
        largeFrame.layer.borderColor = UIColor.purple.cgColor
        largeFrame.layer.borderWidth = 5.0
        
        stackView.layer.frame = CGRect(origin: largeFrame.layer.position, size: largeFrame.layer.frame.size)
        //stackView.frame = CGRect(origin: largeFrame.layer.position, size: largeFrame.layer.frame.size)
        stackView.layer.position.x = 50
        
        
        
        questionLabel.layer.backgroundColor = UIColor.init(red: 240.0/255.0, green: 170.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        
        questionSelector.layer.borderColor = UIColor.purple.cgColor
        questionSelector.layer.borderWidth = 2.0
        

        
        answerSelector.layer.backgroundColor = UIColor.init(red: 230.0/255.0, green: 230.0/255.0, blue: 230.0/255.0, alpha: 1.0).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionSelector.delegate = self
        self.questionSelector.dataSource = self
        self.answerSelector.delegate = self
        
        // Do any additional setup after loading the view.
        // Set up Question selector picker object
        name = collection.name
        answerChoices = collection.answers
        saveButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if collection.name == "" {
            self.enterNamePopUp()
        } else {
            self.navBarTitle.setTitle(collection.name, for: .normal)
        }
    }
    
    func enterNamePopUp() {
        // Build pop up input
        let alertController = UIAlertController(title: "Test Name", message: "Enter the name for this test", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: {(textField: UITextField!) in
            textField.placeholder = "Enter name of test"})
        
        
        
        let action = UIAlertAction(title: "Submit",
                                   style: UIAlertActionStyle.default,
                                   handler: {[weak self]
                                    (paramAction:UIAlertAction!) in
                                    if let textFields = alertController.textFields{
                                        let theTextFields = textFields as [UITextField]
                                        let enteredText = theTextFields[0].text
                                        self!.name = enteredText!
                                        self?.navBarTitle.setTitle(enteredText, for: .normal)
                                    }
            })
        
        alertController.addAction(action)
        
        self.present(alertController, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Rename current test input
    @IBAction func editTestName(_ sender: UIButton) {
        self.enterNamePopUp()
    }
    
    
    // MARK: Input answers
    func assignAnswerChoice(newInput: String, index: Int) {
        if self.answerChoices.count > index {
            self.answerChoices[index] = newInput
        } else {
            self.answerChoices += [newInput]
        }
    }
    func addAnswerToChoices(newInput: String) {
        self.answerChoices += [newInput]
    }
    
    
    @IBAction func inputAnswerSelection(_ sender: UITapGestureRecognizer) {
        print("touched")
        //self.answerSelector.selectionTapped()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Here")
        if sender as! UIBarButtonItem === saveButton {
            print("Save")
            collection = Collection(name: name, answers: answerChoices)
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: MultiChoice Selector stuff
    func selectionTapped(_ button: UIButton) {
        print("Answer Input Controller button pressed")
        var op = self.answerSelector.buttons.index(of: button)
        if self.answerSelector.optionSet == 2 {op! += 5}
        
        self.answerSelector.selection = self.answerSelector.presetOptions[op!]
        self.answerSelector.buttons.forEach({$0.isSelected = false})
        button.isSelected = true
        
        // Go the the next question
        let currentSelection = self.questionSelector.selectedRow(inComponent: 0)
        let nextSelection = currentSelection + 1
        self.assignAnswerChoice(newInput: self.answerSelector.getSelection(), index: self.questionSelector.selectedRow(inComponent: 0))
        
        if self.answerChoices.count > nextSelection {
            // Not new
            self.answerSelector.setSelected(answerChoices[nextSelection])
        } else {
            // New
            self.assignAnswerChoice(newInput: self.answerSelector.getSelection(), index: currentSelection)
            self.answerSelector.resetChoices(1)
            self.questionSelector.reloadAllComponents()
            saveButton.isEnabled = true
        }
        
        self.questionSelector.selectRow(nextSelection, inComponent: 0, animated: true)
    }
    
    //override var intrinsicContentSize : CGSize {
    //    return CGSize(width: 100, height: 250)
    //}
    
    // MARK: Picker Controls
    // What items are in picker
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if answerChoices.count < row+1 {
            return "Next " + String(row+1)
        } else {
            return String(row+1)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // How many rows are in picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answerChoices.count+1
    }
    
    // When new item is picked
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("picked"+String(row))
        
        
        let nextSelection = self.questionSelector.selectedRow(inComponent: 0) + 1
        if self.answerChoices.count > row {
            self.answerSelector.setSelected(answerChoices[row])
            print("old")
        } else {
            print("New")
            self.answerSelector.resetChoices(1)
        }

    }
}
