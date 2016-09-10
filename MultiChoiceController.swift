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
    var selection = String()
    var optionSet = Int()
    var presetOptions: [String] = ["a","b","c","d","e","f","g","h","i","j"]
    var choiceData = ChoiceData()
    var buttonImgs = [Character: UIImage]()
    var buttonImgsActive = [Character: UIImage]()
    var buttons = [UIButton]()
    
    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)!
        self.collectButtonImages()
        self.resetChoices(1)
        //rint("start")
        //self.setSelected("g")
    }
    
    func collectButtonImages() {
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
    
    func setSelected(opSelection: String) {
        let found = presetOptions.indexOf(opSelection)
        var buttonPos: Int
        if (found! > 4) {
            resetChoices(2)
            buttonPos = found! - 5
        } else {
            resetChoices(1)
            buttonPos = found!
        }
        self.buttons[buttonPos].selected = true
        self.selection = presetOptions[buttonPos]
    }
    
    func selectionTapped(button: UIButton) {
        var op = buttons.indexOf(button)
        if self.optionSet == 2 {op! += 5}
        
        self.selection = presetOptions[op!]
        self.buttons.forEach({$0.selected = false})
        button.selected = true
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 100, height: 250)
    }
    
    func resetChoices(setId: Int) {
        print("reset")
        self.selection = ""
        self.optionSet = setId
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.buttons.removeAll()
        //saw this on the web interesting usage http://stackoverflow.com/questions/24312760/how-to-remove-all-subviews-of-a-view-in-swift
        //self.subviews.forEach({ $0.removeFromSuperview() })
        
        let buttonSize: Int = 60
        var startIdx: Int = 0
        if setId == 2 {
            startIdx = 5
        }
        
        for i in startIdx..<startIdx+5 {
            let posIdx = i - startIdx
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
            button.backgroundColor = UIColor.redColor()
            button.frame.origin.y = CGFloat( posIdx * (buttonSize + 20))
            let imgId = presetOptions[i]
            button.setImage(buttonImgs[Character(imgId)], forState: .Normal)
            button.setImage(buttonImgsActive[Character(imgId)], forState: .Selected)
            button.setImage(buttonImgsActive[Character(imgId)], forState: [.Highlighted, .Selected])
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self,
                             action: #selector(MultiChoiceController.selectionTapped(_:)), forControlEvents: .TouchDown)
            //print(posIdx * (45 + 10))
            self.buttons += [button]
            addSubview(button)
            //print("Button made")
        }
    }

}
