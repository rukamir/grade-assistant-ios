//
//  MultiChoiceController.swift
//  Roland Grading Assistant
//
//  Created by Jimmy Roland on 6/2/16.
//  Copyright © 2016 Jimmy Roland. All rights reserved.
//

import UIKit

class MultiChoiceController: UIView {

    // MARK: Properties
    var delegate: AnswerInputViewController?
    var selection = String()
    var optionSet = Int()
    var presetOptions: [String] = ["a","b","c","d","e","f","g","h","i","j"]
    var choiceData = ChoiceData()
    var buttonImgs = [Character: UIImage]()
    var buttonImgsActive = [Character: UIImage]()
    var buttonImgScribble = UIImage()
    var buttons = [UIButton]()
    let buttonSize: Int = 60
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)!
        self.collectButtonImages()
        self.resetChoices(1)
        //rint("start")
        //self.setSelected("g")
    }
    
    func collectButtonImages() {
        buttonImgScribble = UIImage.init(named: "selected_scribble")!
        
        buttonImgs = ["a": UIImage.init(named: "button_a")!,
                      "b": UIImage.init(named: "button_b")!,
                      "c": UIImage.init(named: "button_c")!,
                      "d": UIImage.init(named: "button_d")!,
                      "e": UIImage.init(named: "button_e")!,
                      "f": UIImage.init(named: "button_f")!,
                      "g": UIImage.init(named: "button_g")!,
                      "h": UIImage.init(named: "button_h")!,
                      "i": UIImage.init(named: "button_i")!,
                      "j": UIImage.init(named: "button_j")!]
        
        buttonImgsActive = ["a": UIImage.init(named: "button_a_active")!,
                            "b": UIImage.init(named: "button_b_active")!,
                            "c": UIImage.init(named: "button_c_active")!,
                            "d": UIImage.init(named: "button_d_active")!,
                            "e": UIImage.init(named: "button_e_active")!,
                            "f": UIImage.init(named: "button_f_active")!,
                            "g": UIImage.init(named: "button_g_active")!,
                            "h": UIImage.init(named: "button_h_active")!,
                            "i": UIImage.init(named: "button_i_active")!,
                            "j": UIImage.init(named: "button_j_active")!]
    }
    
    func getSelection()-> String {
        return self.selection
    }
    
    func setSelected(_ opSelection: String) {
        let found = presetOptions.index(of: opSelection)
        var buttonPos: Int
        if (found! > 4) {
            resetChoices(2)
            buttonPos = found! - 5
        } else {
            resetChoices(1)
            buttonPos = found!
        }
        self.buttons[buttonPos].isSelected = true
        updateImageSelected(sender: buttons[buttonPos])
        self.selection = presetOptions[buttonPos]
    }
    
    //func selectionTapped(_ button: UIButton) {
    //    print("MuliChoice button pressed")
    //    var op = buttons.index(of: button)
    //    if self.optionSet == 2 {op! += 5}
    //
    //    self.selection = presetOptions[op!]
    //    self.buttons.forEach({$0.isSelected = false})
    //    button.isSelected = true
    //}
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: 100, height: 250)
    }
    
    func resetChoices(_ setId: Int) {
        print("reset")
        self.selection = ""
        self.optionSet = setId
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.buttons.removeAll()
        //saw this on the web interesting usage http://stackoverflow.com/questions/24312760/how-to-remove-all-subviews-of-a-view-in-swift
        //self.subviews.forEach({ $0.removeFromSuperview() })
        
        
        var startIdx: Int = 0
        if setId == 2 {
            startIdx = 5
        }
        
        for i in startIdx..<startIdx+5 {
            let posIdx = i - startIdx
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            button.backgroundColor = UIColor.red
            button.frame.origin.y = CGFloat( posIdx * (buttonSize + 20))
            let imgId = presetOptions[i]
            button.setImage(buttonImgs[Character(imgId)], for: UIControlState())
            button.setImage(buttonImgsActive[Character(imgId)], for: .selected)
            button.setImage(buttonImgsActive[Character(imgId)], for: [.highlighted, .selected])
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(delegate,
                             action: #selector(delegate!.selectionTapped(_:)), for: .touchDown)
            //print(posIdx * (45 + 10))
            self.buttons += [button]
            addSubview(button)
            //print("Button made")
        }
    }
    
    func updateImageSelected(sender: UIButton) {
        let frontimgview = UIImageView(image: buttonImgScribble) // Create the view holding the image
        frontimgview.frame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize) // The size and position of the front image
        
        sender.addSubview(frontimgview)
    }
    
    // MARK: For guesture recognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
